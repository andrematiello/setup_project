<!--
  COMANDO: /project:deploy-check
  QUANDO ACIONAR: antes de qualquer push com migration, serviço de backend,
  schema, auth, políticas de acesso ou mudança de risco. Chamado pelo /project:release.
  QUEM ACIONA: usuário explicitamente ou /project:release (automático).
  ETAPAS:
  FASE 1 — pré-push: secrets, código, banco, backend, integrações
  → Se tudo ✅: chama /project:done automaticamente
  FASE 2 — pós-deploy: smoke test em produção
  → Se 🔴: rollback e registro em runbook
-->

# /project:deploy-check

Gate de qualidade antes de qualquer push para produção.
Execute antes de `/project:release` ou sempre que a sessão envolver
mudança de risco (banco, auth, backend, integrações, variáveis de ambiente).

> Para cada item: execute o comando indicado, reporte ✅ ou 🔴.
> Não marque ✅ sem executar. Um único 🔴 bloqueia o deploy.

---

## Fase 1 — Verificação pré-push

### 1.1 Secrets e ambiente [GENÉRICO]

- [ ] Nenhum secret no staging area do git:

  ```bash
  git diff --cached --name-only | grep -E "\.(env|key|pem|p12|pfx)$"
  ```

  Esperado: nenhuma saída.

- [ ] Nenhum arquivo `.env` rastreado acidentalmente:

  ```bash
  git ls-files | grep "^\.env"
  ```

  Esperado: nenhuma saída.

- [ ] Variáveis públicas de ambiente não contêm secrets — revisar `.env.example` manualmente.

- [ ] Todas as variáveis de `.env.example` estão configuradas em produção.

### 1.2 Qualidade de código [GENÉRICO]

- [ ] Sem `console.log` com dados sensíveis:

  ```bash
  grep -r "console\.log" src/ --include="*.ts" --include="*.tsx" -l
  ```

- [ ] Sem código comentado esquecido:

  ```bash
  git diff origin/main...HEAD -- "*.ts" "*.tsx" | grep "^+" | grep -E "^\+\s*//"
  ```

- [ ] Testes automatizados passando: [ADAPTÁVEL]

  ```bash
  [PKG_MANAGER] run test
  ```

- [ ] Sem erros de TypeScript: [ADAPTÁVEL]

  ```bash
  [PKG_EXEC] tsc --noEmit
  ```

- [ ] Build sem erros: [ADAPTÁVEL]

  ```bash
  [PKG_MANAGER] run build
  ```

### 1.3 Banco de dados [ADAPTÁVEL]

- [ ] Sem migrations pendentes — verificar com a ferramenta do projeto.
- [ ] Políticas de acesso habilitadas em tabelas novas.
- [ ] Sem migrations destrutivas sem backup confirmado.

### 1.4 Backend / serviços [ADAPTÁVEL]

- [ ] Todas as funções / serviços estão deployados e atualizados.
- [ ] Nenhuma função usa credencial privilegiada antes de validar o usuário.

### 1.5 Integrações [ADAPTÁVEL]

- [ ] Webhooks apontam para URL de produção (não localhost ou staging).
- [ ] Serviços externos em modo produção (não sandbox / test).
- [ ] URLs de callback de autenticação incluem a URL de produção.

---

### Resultado da Fase 1 [GENÉRICO]

Se algum item estiver 🔴:

1. Informe exatamente o que falhou com o output do comando.
2. Bloqueie o deploy e aguarde resolução.
3. Reexecute os itens afetados após a correção.

**Se todos os itens estiverem ✅ — execute `/project:done` agora.**

`/project:done` irá registrar o changelog, validar a documentação,
commitar e fazer o push. O push aciona o deploy automático.
Após a conclusão, prossiga para a Fase 2.

---

## Fase 2 — Verificação pós-deploy [ADAPTÁVEL]

Execute somente após o deploy ter sido concluído.
Marque ✅ apenas após verificação real em produção.

### 2.1 Smoke test

- [ ] Login funciona e redireciona corretamente.
- [ ] Fluxo principal da aplicação funciona sem erro.
- [ ] Rotas protegidas exigem autenticação.
- [ ] Operação central do produto funciona e persiste.
- [ ] Serviços críticos de backend respondem sem erro 500.

---

### Resultado da Fase 2 [GENÉRICO]

Se algum item estiver 🔴:

1. Identifique se é regressão deste deploy ou instabilidade pré-existente.
2. Se for regressão: acione rollback pela plataforma de deploy.
3. Registre o incidente em `docs/runbook.md` antes de nova tentativa.

**Se todos os itens estiverem ✅ — deploy concluído com sucesso.**
