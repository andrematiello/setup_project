---
name: security-audit
description: >
  Skill especializada em auditoria e análise de segurança de aplicações.
  Atua como auditor técnico de segurança de software, avaliando arquitetura, autenticação, autorização, APIs, infraestrutura, CI/CD, IA e processos de desenvolvimento. Produz relatórios estruturados com riscos priorizados, critérios de aceite auditáveis e recomendações baseadas em OWASP, NIST SSDF e Secure by Design.
  
  Use esta skill sempre que o usuário pedir: auditoria de segurança, revisão de segurança, threat modeling, análise de vulnerabilidades, avaliação de maturidade de segurança, checklist de segurança, security review, pentest assessment, análise de risco de aplicação, hardening, conformidade OWASP/NIST, ou qualquer variação de "quero saber se minha aplicação é segura".

  Também dispare quando o usuário mencionar tópicos como: isolamento multi-tenant, proteção de API, gestão de segredos, segurança de pipeline CI/CD, resposta a incidentes, prompt injection, ou segurança de integrações externas.
---

# Security Audit — Auditoria de Segurança de Aplicações

## Checklist diário de segurança (/project:start)

Use este bloco como verificação diária do estado de segurança do projeto. Ele complementa o checklist pré-produção e serve para o início de sessão.

### Variáveis de ambiente

- [ ] nenhum secret em variáveis `VITE_`
- [ ] variáveis públicas limitadas ao que o frontend realmente precisa
- [ ] secrets de backend presentes apenas em ambiente seguro

### RLS

- [ ] toda tabela nova tem RLS habilitado
- [ ] policies novas usam `is_org_member()` ou `has_org_role()`
- [ ] nenhuma query multi-tenant depende só do frontend

### Edge Functions

- [ ] nenhum secret exposto no código
- [ ] nenhuma função privilegiada usa `service_role` antes de validar JWT quando aplicável
- [ ] inputs externos continuam validados com Zod

### Dependências

- [ ] sem vulnerabilidades conhecidas críticas nas dependências principais
- [ ] sem pacote crítico desatualizado com impacto de segurança conhecido

### Stripe

- [ ] webhook aponta para a URL correta do ambiente
- [ ] secrets de webhook não aparecem no frontend
- [ ] modo test/live revisado conforme o ambiente

### Auth

- [ ] confirmação de e-mail continua habilitada em produção
- [ ] URLs de callback e redirect estão na allowlist correta
- [ ] logout continua invalidando sessão via Supabase Auth

## Papel

Você é um auditor técnico sênior de segurança de software. Sua função é conduzir
avaliações rigorosas, fundamentadas em padrões internacionais (OWASP ASVS,
OWASP Top 10, NIST SSDF, CISA Secure by Design), produzindo análises que possam
ser usadas como instrumento de engenharia profissional.

## Princípios de conduta

1. **Rigor técnico acima de generalidades.** Nunca responda com frases vagas
   como "use criptografia forte". Especifique algoritmos, modos, tamanhos de
   chave e contextos de uso.
2. **Cenário real.** Assuma aplicações web modernas, frequentemente SaaS
   multi-tenant, com APIs REST/GraphQL, integrações externas e pipelines CI/CD.
3. **Priorização explícita.** Classifique cada achado como:
   - **Crítico** — risco de comprometimento imediato; corrigir antes de produção.
   - **Alto** — exploração provável; corrigir no próximo ciclo.
   - **Médio** — melhoria de maturidade; planejar no roadmap.
   - **Baixo** — boa prática desejável; implementar quando viável.
4. **Três elementos por domínio.** Toda análise deve conter:
   - O que está sendo avaliado e por quê.
   - Resultado esperado segundo boas práticas.
   - Achados, lacunas e recomendações concretas.
5. **Critérios de aceite auditáveis.** Sempre que possível, converta achados em
   critérios binários aprovado/reprovado com evidência esperada.
6. **Ecossistema completo.** Avalie não apenas código, mas infraestrutura,
   pipeline, dependências, monitoramento, logs, backups e resposta a incidentes.

## Fluxo de trabalho

### 1. Coleta de contexto

Antes de auditar, colete informações sobre a aplicação. Pergunte ao usuário
(se ele ainda não forneceu):

- Tipo de aplicação (web, mobile, API, SaaS)
- Stack tecnológico (linguagem, framework, banco, cloud)
- Modelo de tenancy (single-tenant, multi-tenant)
- Estágio (design, desenvolvimento, produção)
- Ativos críticos (dados sensíveis, PII, financeiros)
- Integrações externas relevantes
- Se usa recursos de IA/LLM

Use essas informações para contextualizar toda a análise.

### 2. Seleção de domínios

A auditoria cobre 30 domínios. Leia o arquivo de referência relevante antes
de analisar cada domínio:

- `references/domains-01-10.md` — Domínios 1-10
- `references/domains-11-20.md` — Domínios 11-20
- `references/domains-21-30.md` — Domínios 21-30

Se o usuário pedir auditoria completa, conduza todos os 30. Se pedir um tema
específico, vá direto ao domínio relevante. Os domínios são:

 1. Arquitetura de segurança
 2. Threat modeling (STRIDE)
 3. Autenticação
 4. Autorização e controle de acesso
 5. Isolamento multi-tenant
 6. Banco de dados e proteção de dados
 7. Criptografia em trânsito e em repouso
 8. Gestão de segredos
 9. Segurança de APIs
10. Validação de entrada e prevenção de injeção
11. Upload de arquivos
12. Sessão, cookies e tokens
13. Frontend seguro
14. Backend como autoridade única
15. Dependências e supply chain
16. CI/CD seguro
17. Ambientes e separação de responsabilidades
18. Logging, auditoria e trilha forense
19. Monitoramento e detecção de anomalias
20. Backup, recuperação e continuidade
21. Resposta a incidentes
22. Secure by design e secure by default
23. Conformidade com padrões (OWASP ASVS, Top 10, NIST SSDF)
24. Testes de segurança (SAST, DAST, pentest)
25. Administração e contas privilegiadas
26. Privacidade e minimização de dados
27. Integrações externas
28. Hardening de infraestrutura
29. Segurança de IA e prompts
30. Critérios objetivos de aceite de segurança

### 3. Formato de saída por domínio

Para cada domínio analisado, use esta estrutura:

```
## [Número]. [Nome do Domínio]

### O que é avaliado e por quê
[Explicação do aspecto de segurança e sua importância no modelo moderno]

### Resultado esperado
[O que uma aplicação madura deve apresentar neste domínio]

### Achados e recomendações

| # | Achado | Severidade | Impacto se explorado | Recomendação | Critério de aceite |
|---|--------|-----------|---------------------|--------------|-------------------|
| 1 | ...    | Crítico/Alto/Médio/Baixo | ... | ... | Aprovado se: ... |

### Referências
[OWASP ASVS seção X, NIST SSDF prática Y, etc.]
```

### 4. Relatório consolidado

Ao final da auditoria, produza um resumo executivo:

- Total de achados por severidade
- Top 15 riscos que exigem ação imediata
- Nível estimado de maturidade de segurança (Inicial / Repetível / Definido / Gerenciado / Otimizado)
- Roadmap sugerido de remediação em 3 fases (imediato, curto prazo, médio prazo)
- Checklist consolidado de critérios de aceite aprovado/reprovado

Gere este relatório como arquivo em `logs/security/security-[data e hora].md` quando a análise for suficientemente completa.

### 5. Adaptação ao que o usuário fornecer

- **Se fornecer código-fonte:** analise o código diretamente, identifique
  padrões inseguros e cite linhas/trechos específicos.
- **Se fornecer arquitetura (diagramas, descrições):** faça threat modeling
  e identifique superfícies de ataque.
- **Se fornecer configurações (Dockerfile, CI/CD, terraform):** avalie
  hardening, segredos, permissões.
- **Se fornecer apenas descrição verbal:** conduza a auditoria por perguntas
  estruturadas, domínio a domínio.
- **Se pedir foco em um domínio:** vá fundo naquele domínio sem forçar
  cobertura completa.

## Regras importantes

- Nunca forneça código de exploração funcional. Descreva vetores de ataque
  conceitualmente para fins de avaliação, sem fornecer payloads prontos.
- Diferencie claramente entre fato técnico e opinião/recomendação.
- Quando uma recomendação depender do contexto da aplicação, diga
  explicitamente quais condições alteram a orientação.
- Use terminologia precisa (ex: "AES-256-GCM" em vez de "criptografia forte").
- Cite as referências normativas (OWASP ASVS V-XX, NIST SSDF PO.1, etc.)
  sempre que aplicável.

---

# Domínios 1–10: Referência Detalhada

## 1. Arquitetura de Segurança

### Perguntas-chave para o usuário

- Quais são as fronteiras de confiança da aplicação?
- Quais ativos são mais críticos (dados financeiros, PII, credenciais)?
- Quais fluxos de dados cruzam fronteiras de rede ou de confiança?
- Existem componentes expostos diretamente à internet?

### O que avaliar

- Diagrama de componentes com fronteiras de confiança demarcadas
- Inventário de ativos críticos e sua classificação de sensibilidade
- Mapeamento de superfícies de ataque (endpoints públicos, interfaces admin, webhooks, filas)
- Fluxos de dados sensíveis entre componentes (autenticação, PII, tokens)
- Princípio de defesa em profundidade: múltiplas camadas de controle
- Segmentação de rede e isolamento de componentes

### Resultado esperado

Modelo de ameaças documentado com riscos priorizados por camada, superfícies
de ataque inventariadas e controles de mitigação mapeados para cada fronteira
de confiança.

### Critérios de aceite

- [ ] Diagrama de arquitetura com fronteiras de confiança existe e está atualizado
- [ ] Inventário de ativos críticos está documentado e classificado
- [ ] Superfícies de ataque estão mapeadas (endpoints, interfaces, integrações)
- [ ] Fluxos de dados sensíveis estão identificados e documentados
- [ ] Cada fronteira de confiança tem pelo menos um controle de segurança

### Referências

OWASP ASVS V1 (Architecture), NIST SSDF PW.1

---

## 2. Threat Modeling

### Perguntas-chave para o usuário

- A equipe já realizou threat modeling formal?
- Quais cenários de ataque são mais preocupantes?
- Existem atores de ameaça específicos relevantes (insiders, competidores, script kiddies)?

### O que avaliar

Aplicar STRIDE sistematicamente:

- **Spoofing:** falsificação de identidade em autenticação e APIs
- **Tampering:** adulteração de dados em trânsito, em repouso ou em parâmetros
- **Repudiation:** ausência de trilha de auditoria que permite negar ações
- **Information Disclosure:** vazamento de dados por erros, logs, respostas verbosas
- **Denial of Service:** esgotamento de recursos, amplificação, abuso de endpoints
- **Elevation of Privilege:** escalada horizontal (entre tenants) e vertical (para admin)

Cenários específicos a modelar:

- Abuso de fluxos de negócio (ex: manipulação de preços, bypass de pagamento)
- Privilege escalation via IDOR, mass assignment, parameter tampering
- Exfiltração de dados via APIs, exports, logs
- Comprometimento de sessão via token theft, session fixation
- Supply chain: dependência comprometida, CI/CD injection

### Resultado esperado

Lista priorizada de ameaças com: descrição do cenário, categoria STRIDE,
probabilidade, impacto, controles mitigatórios existentes e lacunas.

### Critérios de aceite

- [ ] Threat model documentado cobrindo todas as categorias STRIDE
- [ ] Cenários de privilege escalation estão modelados
- [ ] Cenários de exfiltração de dados estão modelados
- [ ] Cada ameaça tem probabilidade e impacto estimados
- [ ] Controles mitigatórios estão mapeados para cada ameaça de risco alto/crítico

### Referências

OWASP Threat Modeling, STRIDE (Microsoft), OWASP ASVS V1.2

---

## 3. Autenticação

### Perguntas-chave para o usuário

- Qual mecanismo de autenticação é usado (senha, OAuth, SSO, passwordless)?
- MFA está disponível? É obrigatório para algum perfil?
- Como funciona o fluxo de recuperação de senha?
- Existe proteção contra brute force e credential stuffing?

### O que avaliar

- Política de senha: comprimento mínimo (>=12 chars), complexidade, verificação contra listas de senhas vazadas (haveibeenpwned)
- MFA: implementação, fatores suportados (TOTP, WebAuthn, SMS), obrigatoriedade para admins
- Proteção contra brute force: rate limiting por IP e por conta, lockout temporário, CAPTCHA progressivo
- Proteção contra credential stuffing: detecção de volume, monitoramento de origens suspeitas
- Enumeração de usuários: respostas genéricas em login/registro/reset ("credenciais inválidas")
- Reset de senha: token de uso único, expiração curta (<=1h), invalidação após uso, sem informação sobre existência da conta
- Gestão de sessão pós-autenticação: criação de nova sessão após login, invalidação da sessão anterior

### Resultado esperado

Fluxo robusto de login, recuperação e sessão sem atalhos inseguros. MFA
disponível para todos e obrigatório para funções privilegiadas.

### Critérios de aceite

- [ ] Senha mínima >= 12 caracteres
- [ ] Senhas são verificadas contra listas de credenciais vazadas
- [ ] MFA está disponível para todos os usuários
- [ ] MFA é obrigatório para contas administrativas
- [ ] Rate limiting protege contra brute force (por IP e por conta)
- [ ] Respostas de login/registro/reset não revelam se a conta existe
- [ ] Token de reset expira em <= 1 hora e é de uso único
- [ ] Nova sessão é criada após autenticação bem-sucedida

### Referências

OWASP ASVS V2 (Authentication), OWASP Top 10 A07:2021, NIST 800-63B

---

## 4. Autorização e Controle de Acesso

### Perguntas-chave para o usuário

- Qual modelo de autorização é usado (RBAC, ABAC, policy-based)?
- A autorização é validada no servidor para toda operação?
- Como é feita a segregação de dados entre tenants?
- Existem testes específicos para IDOR/BOLA?

### O que avaliar

- Modelo de autorização: RBAC com papéis claramente definidos, ou ABAC para cenários complexos
- Validação server-side: toda decisão de acesso é feita no backend, nunca no frontend
- IDOR/BOLA: IDs sequenciais ou previsíveis em URLs/APIs, ausência de verificação de ownership
- Mass assignment: campos protegidos que não devem ser alterados pelo usuário
- Controle por recurso: cada operação CRUD verifica se o usuário tem permissão para aquele recurso específico
- Segregação entre tenants: tenant_id está presente e é verificado em toda query
- Princípio do menor privilégio: papéis com permissões mínimas necessárias
- Deny by default: acesso negado a menos que explicitamente permitido

### Resultado esperado

Isolamento rígido de dados, permissão sempre decidida no backend, deny by
default e zero confiança em parâmetros vindos do cliente.

### Critérios de aceite

- [ ] Toda autorização é validada no servidor
- [ ] Modelo RBAC/ABAC está documentado com papéis e permissões
- [ ] IDs de recursos são verificados contra ownership do usuário (anti-IDOR)
- [ ] tenant_id é filtrado em toda query de banco de dados
- [ ] Deny by default está implementado (acesso negado se não explicitamente permitido)
- [ ] Testes automatizados cobrem cenários de acesso indevido entre papéis
- [ ] Mass assignment é prevenido (campos protegidos não são alteráveis via API)

### Referências

OWASP ASVS V4 (Access Control), OWASP Top 10 A01:2021, OWASP API Top 10 BOLA

---

## 5. Isolamento Multi-tenant

### Perguntas-chave para o usuário

- A aplicação é multi-tenant? Qual modelo (banco compartilhado, schema por tenant, banco por tenant)?
- Como o tenant_id é propagado nas queries?
- Cache, filas e storage são compartilhados entre tenants?
- Logs contêm identificação do tenant?

### O que avaliar

- Modelo de isolamento de banco: RLS (Row Level Security), filtro por tenant_id em toda query, ou schema/banco separado
- Risco de query sem filtro de tenant: uma query sem WHERE tenant_id pode vazar dados cruzados
- Cache: chaves de cache incluem tenant_id para evitar cache poisoning entre tenants
- Storage/arquivos: path ou bucket segregado por tenant, sem possibilidade de path traversal entre tenants
- Filas/mensageria: mensagens são roteadas/filtradas por tenant
- Logs: tenant_id presente em todo log para auditoria e isolamento de investigação
- Índices e buscas: full-text search e índices respeitam isolamento de tenant
- Background jobs: processamento assíncrono respeita contexto do tenant

### Resultado esperado

Impossibilidade de vazamento cruzado entre clientes, inclusive por erros de
query, indexação, cache ou armazenamento compartilhado.

### Critérios de aceite

- [ ] Toda query de banco inclui filtro por tenant_id (ou usa RLS)
- [ ] Chaves de cache incluem tenant_id
- [ ] Storage de arquivos é segregado por tenant
- [ ] Filas e background jobs preservam contexto de tenant
- [ ] Full-text search respeita isolamento de tenant
- [ ] Logs incluem tenant_id em todos os registros
- [ ] Testes automatizados validam que tenant A não acessa dados de tenant B

### Referências

OWASP ASVS V1.4 (Multi-tenancy), OWASP API Top 10 BFLA

---

## 6. Banco de Dados e Proteção de Dados

### Perguntas-chave para o usuário

- Qual banco é usado e como as credenciais de acesso são geridas?
- Existe separação de ambientes (dev/staging/prod) com credenciais distintas?
- Quais dados sensíveis são armazenados e como são protegidos?
- Existe política de retenção e descarte de dados?

### O que avaliar

- Princípio do menor privilégio: aplicação usa conta de banco com permissões mínimas (sem DROP, GRANT, etc.)
- Row Level Security (RLS): ativado para tabelas multi-tenant
- Segregação de ambientes: credenciais diferentes para dev, staging, prod; dados de prod nunca copiados para dev sem masking
- Data masking: dados sensíveis mascarados em ambientes não-produtivos
- Criptografia de colunas sensíveis: PII, dados financeiros, tokens cifrados em repouso
- Trilha de auditoria: tabelas de auditoria ou CDC para rastrear alterações em dados críticos
- Retenção e descarte: política definida de quanto tempo dados são mantidos e como são descartados (soft delete com expurgo, hard delete)
- Backups: backup criptografado, testado periodicamente

### Resultado esperado

Governança forte dos dados com acesso minimizado, trilha de auditoria,
masking em ambientes não-produtivos e política clara de retenção.

### Critérios de aceite

- [ ] Conta de banco da aplicação tem permissões mínimas necessárias
- [ ] RLS está ativo em tabelas multi-tenant (se aplicável)
- [ ] Credenciais de banco são distintas por ambiente
- [ ] Dados de produção não são copiados para dev/staging sem masking
- [ ] Dados sensíveis (PII, financeiros) são cifrados em repouso
- [ ] Trilha de auditoria registra alterações em dados críticos
- [ ] Política de retenção e descarte está documentada e implementada

### Referências

OWASP ASVS V8 (Data Protection), NIST SSDF PW.6

---

## 7. Criptografia em Trânsito e em Repouso

### Perguntas-chave para o usuário

- TLS está configurado em todas as comunicações externas e internas?
- Quais dados são cifrados em repouso e com quais algoritmos?
- Como as chaves de criptografia são geridas e rotacionadas?

### O que avaliar

- TLS: versão mínima 1.2 (preferível 1.3), cipher suites seguras, HSTS habilitado
- Certificados: renovação automatizada, monitoramento de expiração
- Criptografia em repouso: AES-256-GCM ou ChaCha20-Poly1305 para dados sensíveis
- Hashing de senhas: Argon2id (preferível), bcrypt ou scrypt com custo adequado
- Gestão de chaves: chaves armazenadas em KMS (AWS KMS, GCP KMS, HashiCorp Vault), nunca no código
- Rotação de chaves: política definida e mecanismo implementado sem downtime
- Segregação de material criptográfico: chaves diferentes para propósitos diferentes (autenticação vs. armazenamento vs. assinatura)
- Comunicações internas: TLS entre microserviços (mTLS se possível)

### Resultado esperado

Política clara de TLS, cifragem de dados sensíveis com algoritmos modernos,
gestão correta de chaves via KMS e rotação periódica.

### Critérios de aceite

- [ ] TLS >= 1.2 em todas as comunicações externas
- [ ] HSTS está habilitado com max-age adequado (>= 1 ano)
- [ ] Dados sensíveis em repouso são cifrados com AES-256-GCM ou equivalente
- [ ] Senhas são hashadas com Argon2id, bcrypt ou scrypt
- [ ] Chaves de criptografia estão em KMS, nunca em código ou config files
- [ ] Rotação de chaves está implementada com política definida
- [ ] Comunicações entre microserviços usam TLS (mTLS para alta segurança)

### Referências

OWASP ASVS V6 (Cryptography), OWASP Top 10 A02:2021, NIST 800-175B

---

## 8. Gestão de Segredos

### Perguntas-chave para o usuário

- Onde são armazenados segredos (API keys, tokens, credenciais de banco)?
- Existe rotação periódica de segredos?
- Segredos aparecem em logs, frontend ou repositório de código?

### O que avaliar

- Armazenamento centralizado: vault dedicado (HashiCorp Vault, AWS Secrets Manager, GCP Secret Manager)
- Zero segredo hardcoded: nenhum segredo em código-fonte, Dockerfiles ou configs versionados
- Variáveis de ambiente: usadas como transporte, não como armazenamento permanente
- Rotação: política e mecanismo de rotação periódica sem downtime
- Auditoria de acesso: quem acessou qual segredo e quando
- Scanning de repositório: ferramentas como GitLeaks, TruffleHog rodando em CI
- Segredos no frontend: verificação de que nenhuma API key, token ou credencial é exposta no código cliente
- Segredos em logs: sanitização para evitar logging acidental de credenciais

### Resultado esperado

Centralização segura, rotação periódica, auditoria de acesso e zero
segredo em código, logs ou frontend.

### Critérios de aceite

- [ ] Segredos são armazenados em vault dedicado (não em código ou env files versionados)
- [ ] Nenhum segredo está hardcoded no repositório (validado por scanning)
- [ ] Rotação de segredos tem política definida e mecanismo implementado
- [ ] Secret scanning roda em CI/CD e bloqueia commits com segredos
- [ ] Nenhum segredo é exposto no frontend
- [ ] Logs são sanitizados para não conter segredos
- [ ] Acesso a segredos é auditado (quem, quando, qual segredo)

### Referências

OWASP ASVS V2.10 (Secrets), NIST SSDF PO.5, CIS Benchmarks

---

## 9. Segurança de APIs

### Perguntas-chave para o usuário

- Quais APIs são públicas e quais são internas?
- Qual mecanismo de autenticação e autorização as APIs usam?
- Existe rate limiting e proteção contra abuso automatizado?
- Validação de entrada é feita por schema ou manualmente?

### O que avaliar

- Autenticação: toda API requer autenticação (exceto endpoints explicitamente públicos)
- Autorização: cada endpoint valida permissão do usuário autenticado
- Rate limiting: por IP, por usuário, por endpoint, com respostas 429 adequadas
- Validação de entrada: schema enforcement (JSON Schema, Zod, Joi), rejeição de campos desconhecidos
- Paginação segura: cursor-based ou com limites de page size, sem permitir dump de tabela inteira
- Idempotência: operações de escrita suportam idempotency key para evitar duplicação
- Respostas de erro: mensagens genéricas sem stack traces, paths internos ou detalhes de implementação
- Versionamento: estratégia clara de deprecação e versionamento
- Proteção contra abuso: detecção de fuzzing, scanning automatizado, uso anômalo

### Resultado esperado

Camada de API previsível, validada, resistente a automação maliciosa,
fuzzing e exploração de endpoints.

### Critérios de aceite

- [ ] Toda API requer autenticação (exceto endpoints documentados como públicos)
- [ ] Autorização é verificada em cada endpoint
- [ ] Rate limiting está implementado (por IP, por usuário e por endpoint)
- [ ] Entrada é validada por schema com rejeição de campos desconhecidos
- [ ] Paginação tem limite máximo de page size
- [ ] Erros não expõem stack traces ou detalhes internos
- [ ] Endpoints de escrita suportam idempotência
- [ ] Documentação da API está atualizada (OpenAPI/Swagger)

### Referências

OWASP API Security Top 10, OWASP ASVS V13 (API), NIST SSDF PW.5

---

## 10. Validação de Entrada e Prevenção de Injeção

### Perguntas-chave para o usuário

- Queries de banco usam parametrização ou concatenação de strings?
- Existe sanitização de HTML/JS para prevenção de XSS?
- A aplicação faz requisições a URLs fornecidas pelo usuário (risco SSRF)?
- Existe template engine com auto-escaping habilitado?

### O que avaliar

- SQL Injection: uso exclusivo de queries parametrizadas/prepared statements, ORM seguro
- XSS: output encoding contextual (HTML, JS, URL, CSS), CSP restritiva, template engine com auto-escaping
- Command Injection: nunca passar input do usuário para shell; se necessário, usar APIs programáticas
- Path Traversal: validação e normalização de paths, blocklist de "../", chroot quando aplicável
- SSRF: allowlist de domínios/IPs permitidos, bloqueio de IPs internos (169.254.x.x, 10.x.x.x, etc.)
- Template Injection: se usa template engines server-side, garantir que input do usuário não é interpretado como template
- Upload malicioso: coberto no domínio 11
- Header Injection: validação de headers customizados, CRLF injection prevention
- Mass Assignment: proteger campos sensíveis contra binding automático

### Resultado esperado

Validação rigorosa em toda entrada, sanitização contextual na saída, uso
exclusivo de queries parametrizadas e defesa contra SSRF/path traversal.

### Critérios de aceite

- [ ] Todas as queries de banco usam parametrização (zero concatenação de strings)
- [ ] Output encoding contextual está implementado (HTML, JS, URL)
- [ ] CSP está configurada e é restritiva
- [ ] Input do usuário nunca é passado para shell commands
- [ ] Requisições a URLs externas validam contra allowlist (anti-SSRF)
- [ ] Paths de arquivos são validados e normalizados (anti-path-traversal)
- [ ] Template engine tem auto-escaping habilitado
- [ ] Mass assignment é prevenido com allowlists de campos

### Referências

OWASP ASVS V5 (Validation), OWASP Top 10 A03:2021, CWE-89, CWE-79, CWE-918

---

# Domínios 11–20: Referência Detalhada

## 11. Upload de Arquivos

### Perguntas-chave para o usuário

- A aplicação permite upload de arquivos? Quais tipos?
- Onde os arquivos são armazenados (local, S3, GCS)?
- Existe validação do conteúdo real do arquivo (magic bytes)?
- Arquivos enviados são servidos diretamente ou processados?

### O que avaliar

- Validação de tipo real: verificar magic bytes/file signature, não confiar apenas na extensão ou Content-Type
- Limite de tamanho: tamanho máximo definido por tipo de arquivo e por usuário
- Extensão: allowlist de extensões permitidas (não blocklist)
- Conteúdo: scanning de malware/antivírus antes de disponibilizar
- Armazenamento seguro: fora da webroot, em bucket separado, sem permissão de execução
- Renomeação: arquivos salvos com nome gerado (UUID), nunca com nome original do usuário
- Isolamento: arquivos servidos de domínio separado (CDN/bucket) para evitar cookie leaking
- Quarentena: arquivos ficam em status pendente até validação completa
- Imagens: reprocessamento (resize/re-encode) para eliminar payloads embutidos em metadados

### Resultado esperado

Pipeline de upload com validação profunda (magic bytes, tamanho, antivírus),
quarentena, renomeação segura e ausência de execução acidental.

### Critérios de aceite

- [ ] Tipo de arquivo é validado por magic bytes, não apenas extensão
- [ ] Allowlist de extensões permitidas está configurada
- [ ] Tamanho máximo de upload está definido e enforced
- [ ] Scanning de malware roda antes do arquivo ficar disponível
- [ ] Arquivos são salvos com nome gerado (UUID), fora da webroot
- [ ] Arquivos são servidos de domínio/origin separado
- [ ] Imagens são reprocessadas para remover metadados/payloads

### Referências

OWASP ASVS V12 (Files), CWE-434

---

## 12. Sessão, Cookies e Tokens

### Perguntas-chave para o usuário

- Qual é o mecanismo de sessão (cookie-based, JWT, opaque tokens)?
- Cookies têm flags HttpOnly, Secure e SameSite?
- Existe refresh token? Como funciona a revogação?
- Sessões são invalidadas no logout e na troca de senha?

### O que avaliar

- Cookies: flags HttpOnly (sempre), Secure (sempre em prod), SameSite=Lax ou Strict
- Expiração: sessão com tempo de vida definido (idle timeout + absolute timeout)
- Refresh token: armazenado de forma segura, com rotação a cada uso (refresh token rotation)
- Revogação: mecanismo server-side para invalidar sessões/tokens (não confiar apenas em expiração do JWT)
- Binding: sessão vinculada a fingerprint do cliente (IP, user-agent) como camada adicional
- Detecção de reuso: se um refresh token é usado duas vezes, invalidar toda a família de tokens
- Logout: invalidação efetiva no servidor, não apenas remoção do cookie no cliente
- Troca de senha/MFA: invalidação de todas as outras sessões ativas
- Session fixation: gerar novo session ID após autenticação

### Resultado esperado

Gestão segura do ciclo de vida da autenticação, com revogação efetiva,
refresh token rotation e contenção de roubo de token.

### Critérios de aceite

- [ ] Cookies têm HttpOnly, Secure e SameSite configurados
- [ ] Sessão tem idle timeout e absolute timeout definidos
- [ ] Refresh token é rotacionado a cada uso
- [ ] Reuso de refresh token invalida toda a família de tokens
- [ ] Logout invalida a sessão no servidor
- [ ] Troca de senha invalida todas as outras sessões
- [ ] Novo session ID é gerado após autenticação (anti-fixation)

### Referências

OWASP ASVS V3 (Session Management), OWASP Top 10 A07:2021

---

## 13. Frontend Seguro

### Perguntas-chave para o usuário

- Quais dados ficam acessíveis no frontend (localStorage, sessionStorage, variáveis globais)?
- CSP (Content Security Policy) está configurada?
- Lógica de autorização é replicada ou depende do frontend?
- Existem segredos ou API keys no código cliente?

### O que avaliar

- Nenhum segredo no frontend: API keys, tokens de serviço, credenciais nunca no código cliente
- CSP: política restritiva, sem unsafe-inline/unsafe-eval quando possível, nonces ou hashes para scripts
- armazenamento local: dados sensíveis (tokens, PII) não devem ficar em localStorage (vulnerável a XSS)
- Minimização de dados: frontend recebe apenas os dados necessários para a view, nunca campos extras
- Estados sensíveis: status de pagamento, papéis do usuário, permissões não são decididos pelo frontend
- Headers de segurança: X-Content-Type-Options: nosniff, X-Frame-Options: DENY, Referrer-Policy
- Subresource Integrity (SRI): para scripts e CSS de CDNs externos
- Source maps: não publicar source maps em produção

### Resultado esperado

Cliente enxuto, sem credenciais, sem lógica de segurança e com políticas
de navegador endurecidas (CSP, HSTS, X-Frame-Options).

### Critérios de aceite

- [ ] Nenhum segredo ou credencial existe no código frontend
- [ ] CSP está configurada e é restritiva (sem unsafe-inline se possível)
- [ ] Dados sensíveis não são armazenados em localStorage/sessionStorage
- [ ] Frontend recebe apenas os dados necessários para a view
- [ ] Headers de segurança estão configurados (X-Content-Type-Options, X-Frame-Options, Referrer-Policy)
- [ ] Scripts de CDN usam Subresource Integrity (SRI)
- [ ] Source maps não são publicados em produção

### Referências

OWASP ASVS V14 (Configuration), OWASP Secure Headers Project

---

## 14. Backend como Autoridade Única

### Perguntas-chave para o usuário

- Regras de negócio (preço, desconto, permissão) são validadas no servidor?
- O frontend toma decisões de acesso que não são re-validadas no backend?
- Existem endpoints que confiam em dados enviados pelo cliente sem re-verificação?

### O que avaliar

- Toda regra de negócio crítica é enforced no servidor, não no cliente
- Autorização: decisões de acesso são calculadas server-side a cada requisição
- Cálculos financeiros: preços, descontos, impostos são calculados e validados no backend
- Limites: rate limits, quotas e limites de uso são verificados server-side
- Estado: transições de estado de objetos de negócio são validadas no servidor
- Dados do cliente: parâmetros recebidos do frontend são tratados como untrusted input

### Resultado esperado

Zero confiança indevida no cliente. Toda validação, autorização e regra
de negócio é decidida exclusivamente pelo servidor.

### Critérios de aceite

- [ ] Toda regra de negócio crítica é validada no servidor
- [ ] Decisões de autorização são feitas server-side a cada requisição
- [ ] Cálculos financeiros são validados no backend
- [ ] Parâmetros do cliente são tratados como untrusted input
- [ ] Transições de estado são validadas no servidor
- [ ] Frontend não toma decisões de acesso definitivas

### Referências

OWASP ASVS V4.1, OWASP Top 10 A04:2021

---

## 15. Dependências e Supply Chain

### Perguntas-chave para o usuário

- Existe inventário de dependências (SBOM)?
- Dependências são atualizadas regularmente?
- Lockfiles estão commitados e são verificados?
- Existe scanning de vulnerabilidades em dependências?

### O que avaliar

- SBOM: inventário completo de dependências diretas e transitivas
- Lockfiles: package-lock.json, yarn.lock, poetry.lock commitados e verificados
- Pinning: versões fixas em produção, sem ranges que permitam updates automáticos não testados
- Scanning: ferramentas como Dependabot, Snyk, npm audit rodando em CI
- Vulnerabilidades conhecidas: CVEs em dependências são tratadas com SLA definido
- Pacotes abandonados: dependências sem manutenção há >2 anos identificadas
- Integridade: verificação de checksums de pacotes baixados
- Licenças: compatibilidade de licenças verificada

### Resultado esperado

Cadeia de dependências monitorada, inventariada, com scanning contínuo
e atualização com critério.

### Critérios de aceite

- [ ] SBOM (inventário de dependências) é gerado e mantido
- [ ] Lockfiles estão commitados no repositório
- [ ] Scanning de vulnerabilidades roda em CI/CD
- [ ] CVEs críticas têm SLA de correção definido (ex: 48h para crítico, 7d para alto)
- [ ] Dependências abandonadas estão identificadas e com plano de substituição
- [ ] Versões em produção são pinadas (sem ranges automáticos)

### Referências

OWASP ASVS V14.2, OWASP Top 10 A06:2021, NIST SSDF PW.4

---

## 16. CI/CD Seguro

### Perguntas-chave para o usuário

- Como funciona o pipeline de CI/CD?
- Segredos são acessíveis no pipeline? Como são protegidos?
- Code review é obrigatório antes de merge para main/prod?
- Quais verificações de segurança rodam no pipeline?

### O que avaliar

- Segredos no pipeline: armazenados no sistema de CI (GitHub Secrets, etc.), nunca em código
- Branch protection: main/prod protegidos, merge requer aprovação de code review
- Gates de segurança: SAST, dependency scanning, secret scanning como etapas obrigatórias
- Artefatos: builds são assinados ou verificáveis, não podem ser adulterados pós-build
- Ambiente de build: runners isolados, sem acesso persistente a credenciais de produção
- Promoção de build: artefato que vai para prod é o mesmo que foi testado (não reconstrói)
- Audit trail: quem fez deploy, quando, qual commit, qual artefato
- Rollback: mecanismo de rollback rápido em caso de deploy problemático

### Resultado esperado

Pipeline com gates de segurança, revisão obrigatória, segredos protegidos
e rastreabilidade completa do que foi publicado.

### Critérios de aceite

- [ ] Segredos no pipeline são armazenados no sistema de CI, nunca em código
- [ ] Branch protection exige code review antes de merge para main/prod
- [ ] SAST roda como gate obrigatório no pipeline
- [ ] Dependency scanning roda como gate obrigatório
- [ ] Secret scanning roda como gate obrigatório
- [ ] Builds são verificáveis (assinados ou com checksum)
- [ ] Deploy para prod requer aprovação explícita
- [ ] Audit trail de deploys existe (quem, quando, qual commit)

### Referências

NIST SSDF PO.3, SLSA Framework, CIS Software Supply Chain Security

---

## 17. Ambientes e Separação de Responsabilidades

### Perguntas-chave para o usuário

- Existem ambientes separados (dev, staging, prod)?
- Credenciais são compartilhadas entre ambientes?
- Quem tem acesso a produção?
- Dados de produção são usados em outros ambientes?

### O que avaliar

- Separação: dev, staging e prod são ambientes isolados com credenciais distintas
- Acesso: produção tem acesso restrito com controle rigoroso
- Contas de serviço: distintas por ambiente, com permissões mínimas
- Dados: dados de produção nunca são copiados para dev/staging sem anonimização
- Configuração: configs sensíveis são geridas por ambiente, não hardcoded
- Feature flags: features não testadas não alcançam produção sem controle
- Acesso administrativo: JIT (Just-In-Time) access quando possível

### Resultado esperado

Isolamento operacional completo entre ambientes, com governança clara
de quem pode fazer o quê em cada ambiente.

### Critérios de aceite

- [ ] Dev, staging e prod são ambientes isolados
- [ ] Credenciais são distintas por ambiente
- [ ] Acesso a produção é restrito e auditado
- [ ] Dados de produção não vão para outros ambientes sem anonimização
- [ ] Contas de serviço têm permissões mínimas por ambiente
- [ ] Acessos administrativos são temporários (JIT) quando possível

### Referências

OWASP ASVS V14.1, NIST SSDF PO.5, CIS Benchmarks

---

## 18. Logging, Auditoria e Trilha Forense

### Perguntas-chave para o usuário

- Quais eventos são logados?
- Dados sensíveis aparecem nos logs?
- Logs são centralizados e protegidos contra adulteração?
- Existe retenção definida para logs?

### O que avaliar

- Eventos críticos logados: login (sucesso/falha), alterações de permissão, acesso a dados sensíveis, ações admin, erros de autorização, alterações de configuração
- Dados sensíveis nos logs: senhas, tokens, PII, números de cartão NUNCA devem aparecer em logs
- Formato estruturado: JSON ou formato parseável, com timestamp, user_id, tenant_id, action, resource, result
- Centralização: logs enviados para sistema centralizado (ELK, Datadog, CloudWatch)
- Integridade: logs protegidos contra adulteração (append-only, assinatura, ou armazenamento imutável)
- Retenção: política definida de quanto tempo logs são mantidos
- Correlação: request_id/trace_id para correlacionar eventos entre serviços

### Resultado esperado

Logging útil, auditável, centralizado, sem dados sensíveis e com
estrutura que permita investigação forense eficaz.

### Critérios de aceite

- [ ] Eventos de segurança críticos são logados (login, permissão, admin, erros de authz)
- [ ] Logs NÃO contêm senhas, tokens, PII ou dados de cartão
- [ ] Logs são estruturados (JSON) com timestamp, user_id, tenant_id, action
- [ ] Logs são centralizados em plataforma dedicada
- [ ] Logs são protegidos contra adulteração
- [ ] Política de retenção de logs está definida
- [ ] Request/trace ID permite correlação entre serviços

### Referências

OWASP ASVS V7 (Logging), OWASP Top 10 A09:2021, NIST SSDF PW.6

---

## 19. Monitoramento e Detecção de Anomalias

### Perguntas-chave para o usuário

- Existem alertas configurados para eventos suspeitos?
- A equipe é notificada de picos de erro ou abuso de API?
- Existe monitoramento de acessos fora de padrão?

### O que avaliar

- Alertas de segurança: login suspeito (múltiplas falhas, localização incomum), privilege escalation attempt
- Picos de erro: taxa de 4xx/5xx acima do normal, indicando scanning ou ataque
- Abuso de API: rate limit hits, padrões de fuzzing, tentativas de injeção
- Acessos fora de padrão: exportações em massa, acessos em horários incomuns, queries pesadas
- Ações administrativas: todas as ações admin são monitoradas e alertadas
- Health checks: monitoramento de disponibilidade e performance de componentes críticos
- Escalação: cadeia de comunicação definida para alertas de segurança
- Dashboards: visibilidade operacional para equipe de segurança/ops

### Resultado esperado

Capacidade de detectar comprometimentos e agir antes do dano se ampliar,
com alertas contextuais e cadeia de escalação definida.

### Critérios de aceite

- [ ] Alertas estão configurados para múltiplas falhas de login
- [ ] Alertas estão configurados para picos de erro (4xx/5xx)
- [ ] Alertas estão configurados para rate limit hits excessivos
- [ ] Exportações em massa são monitoradas e alertam
- [ ] Ações administrativas geram alertas
- [ ] Cadeia de escalação de incidentes está definida
- [ ] Dashboards de segurança/ops estão disponíveis

### Referências

OWASP ASVS V7.4, NIST CSF DE.AE, NIST CSF DE.CM

---

## 20. Backup, Recuperação e Continuidade

### Perguntas-chave para o usuário

- Backups são feitos com qual frequência e para onde?
- Backups são criptografados?
- Restauração foi testada recentemente?
- RPO e RTO estão definidos?

### O que avaliar

- Frequência: backup adequado ao RPO definido (ex: diário para RPO de 24h)
- Criptografia: backups cifrados em repouso e em trânsito
- Imutabilidade: backups protegidos contra deleção/modificação (immutable storage, versioning)
- Teste de restauração: restauração é testada periodicamente (pelo menos trimestralmente)
- RPO (Recovery Point Objective): quanto de dado pode ser perdido? Definido e documentado
- RTO (Recovery Time Objective): quanto tempo para recuperar? Definido e documentado
- Plano de continuidade: procedimento documentado para recuperação em caso de desastre
- Separação: backups em região/conta diferente da produção
- Ransomware: proteção contra cenário onde atacante deleta backups antes de cifrar dados

### Resultado esperado

Recuperação comprovada por testes periódicos, com RPO e RTO definidos,
backups criptografados e imutáveis, em localização separada da produção.

### Critérios de aceite

- [ ] RPO e RTO estão definidos e documentados
- [ ] Frequência de backup é adequada ao RPO
- [ ] Backups são criptografados em repouso e em trânsito
- [ ] Backups são imutáveis (protegidos contra deleção)
- [ ] Restauração é testada pelo menos trimestralmente
- [ ] Backups estão em região/conta separada da produção
- [ ] Plano de continuidade está documentado
- [ ] Cenário de ransomware está coberto no plano

### Referências

NIST CSF PR.IP-4, OWASP ASVS V14, ISO 22301

---

# Domínios 21–30: Referência Detalhada

## 21. Resposta a Incidentes

### Perguntas-chave para o usuário

- Existe um plano de resposta a incidentes documentado?
- A equipe sabe quem contatar em caso de incidente de segurança?
- Já houve simulação ou tabletop exercise?
- Existem playbooks para cenários específicos?

### O que avaliar

- Plano documentado: procedimento para identificação, contenção, erradicação, recuperação e lições aprendidas
- Playbooks específicos para:
  - Comprometimento de conta de usuário
  - Vazamento de dados / data breach
  - Invasão de ambiente (servidor, container, cloud account)
  - Ransomware
  - Abuso interno (insider threat)
  - Falha de fornecedor / supply chain compromise
- Cadeia de comunicação: quem é notificado, em qual ordem, por qual canal
- Comunicação externa: template para notificação de clientes e autoridades (LGPD, GDPR)
- Preservação de evidências: procedimento para não destruir logs/artefatos durante investigação
- Simulação: tabletop exercises ou war games realizados periodicamente
- Post-mortem: processo de análise pós-incidente com ações corretivas rastreadas

### Resultado esperado

Playbooks claros de contenção, erradicação, comunicação e recuperação
para os cenários mais prováveis, testados por simulação.

### Critérios de aceite

- [ ] Plano de resposta a incidentes está documentado
- [ ] Playbooks existem para pelo menos: conta comprometida, data breach, ransomware
- [ ] Cadeia de comunicação (interna e externa) está definida
- [ ] Procedimento de preservação de evidências está documentado
- [ ] Simulação/tabletop exercise foi realizada nos últimos 12 meses
- [ ] Processo de post-mortem com ações rastreadas existe
- [ ] Template de notificação para autoridades (LGPD/GDPR) está preparado

### Referências

NIST CSF RS, NIST 800-61, OWASP Incident Response

---

## 22. Secure by Design e Secure by Default

### Perguntas-chave para o usuário

- O produto nasce com padrões seguros ativados por padrão?
- O cliente precisa configurar algo para estar seguro?
- Existem features inseguras habilitadas por default?

### O que avaliar

- Defaults seguros: contas criadas com MFA sugerido, permissões mínimas, sessão com timeout
- Sem configuração manual para segurança básica: o produto é seguro out-of-the-box
- Features arriscadas desabilitadas por padrão: acesso público, API keys sem expiração, permissões amplas
- Eliminação de protocolos/ciphers legados: sem suporte a TLS 1.0/1.1, MD5, SHA1 para segurança
- Logging de segurança ativo por padrão: não depender de opt-in para ter auditoria
- Rate limiting ativo por padrão: proteção contra abuso sem configuração extra
- Princípio da CISA: segurança séria vem de fábrica, não como add-on pago

### Resultado esperado

Arquitetura que minimize erro do operador, remova padrões inseguros e
não exija configuração manual para o básico.

### Critérios de aceite

- [ ] Produto é seguro na instalação padrão (sem configuração extra)
- [ ] Permissões padrão seguem princípio do menor privilégio
- [ ] Features arriscadas estão desabilitadas por padrão
- [ ] Logging de segurança está ativo por padrão
- [ ] Rate limiting está ativo por padrão
- [ ] Protocolos/ciphers legados não são suportados
- [ ] Segurança não é um add-on pago ou opcional

### Referências

CISA Secure by Design, NIST SSDF PW.1, OWASP ASVS V1.1

---

## 23. Conformidade com Padrões Reconhecidos

### Perguntas-chave para o usuário

- A aplicação já foi mapeada contra algum framework (OWASP ASVS, Top 10)?
- Existe checklist de conformidade em uso?
- Qual nível de ASVS é o alvo (L1, L2, L3)?

### O que avaliar

- OWASP Top 10 (2021): mapear cada item contra a aplicação
  - A01: Broken Access Control
  - A02: Cryptographic Failures
  - A03: Injection
  - A04: Insecure Design
  - A05: Security Misconfiguration
  - A06: Vulnerable Components
  - A07: Authentication Failures
  - A08: Software and Data Integrity Failures
  - A09: Security Logging and Monitoring Failures
  - A10: Server-Side Request Forgery
- OWASP ASVS: avaliação por nível (L1 mínimo, L2 para maioria, L3 para alta segurança)
- NIST SSDF: práticas de desenvolvimento seguro integradas no SDLC
- Gap analysis: lacunas identificadas com plano de remediação

### Resultado esperado

Checklist objetivo com nível de aderência, lacunas identificadas e plano
de remediação priorizado.

### Critérios de aceite

- [ ] Mapeamento contra OWASP Top 10 está completo
- [ ] Nível de ASVS alvo está definido (L1/L2/L3)
- [ ] Gap analysis contra ASVS está documentado
- [ ] Práticas NIST SSDF estão mapeadas no SDLC
- [ ] Plano de remediação com prazos está definido para lacunas encontradas
- [ ] Revisão de conformidade é feita periodicamente (pelo menos anualmente)

### Referências

OWASP ASVS, OWASP Top 10 2021, NIST SSDF

---

## 24. Testes de Segurança

### Perguntas-chave para o usuário

- Quais testes de segurança rodam no SDLC?
- SAST e DAST estão integrados no CI/CD?
- Pentest externo é realizado? Com qual frequência?
- Testes de autorização são automatizados?

### O que avaliar

- SAST: análise estática integrada no CI, cobrindo OWASP Top 10
- DAST: análise dinâmica rodando contra ambiente de staging
- Dependency scanning: verificação de CVEs em dependências
- Secret scanning: detecção de segredos em código e configs
- Pentest: teste de penetração externo pelo menos anualmente, ou após mudanças significativas
- Revisão manual de código: para componentes críticos (autenticação, autorização, pagamento)
- Testes de autorização: testes automatizados que verificam acesso indevido entre papéis e tenants
- Fuzzing: para APIs e parsers críticos
- Bug bounty: programa de recompensa para vulnerabilidades (para produtos com maturidade adequada)

### Resultado esperado

Esteira contínua de validação com SAST, DAST, dependency scanning, pentest
periódico e testes específicos de autorização.

### Critérios de aceite

- [ ] SAST está integrado no CI/CD e bloqueia builds com achados críticos
- [ ] DAST roda contra staging periodicamente
- [ ] Dependency scanning roda em CI/CD
- [ ] Secret scanning roda em CI/CD
- [ ] Pentest externo é realizado pelo menos anualmente
- [ ] Testes automatizados de autorização existem (cross-tenant, cross-role)
- [ ] Achados de segurança têm SLA de correção definido

### Referências

OWASP ASVS V14.5, NIST SSDF PW.7, NIST SSDF PW.8

---

## 25. Administração e Contas Privilegiadas

### Perguntas-chave para o usuário

- Como funciona o painel administrativo?
- Ações críticas exigem re-autenticação (step-up)?
- Existe aprovação dupla para operações destrutivas?
- Acessos administrativos são auditados?

### O que avaliar

- MFA obrigatório: admins sempre com MFA, sem exceção
- Step-up authentication: ações críticas (alterar permissões, deletar dados, acessar PII) exigem re-autenticação
- Aprovação dupla: operações destrutivas ou de alto impacto requerem segundo aprovador
- Trilha de auditoria: toda ação administrativa é logada com detalhes (quem, quando, o quê, sobre quem)
- Mínimo privilégio: papéis admin granulares (não um único "super admin" com acesso total)
- Acesso JIT: acesso administrativo concedido temporariamente, com expiração
- Painel separado: interface admin em URL/rede separada se possível
- Proteção contra account takeover de admin: alertas especiais, monitoramento reforçado

### Resultado esperado

Proteção reforçada, rastreabilidade completa e mínimo privilégio para
todas as contas administrativas.

### Critérios de aceite

- [ ] MFA é obrigatório para todas as contas administrativas
- [ ] Ações críticas exigem step-up authentication
- [ ] Operações destrutivas requerem aprovação dupla
- [ ] Toda ação administrativa é logada com detalhes
- [ ] Papéis admin são granulares (não um único super admin)
- [ ] Acessos admin são temporários (JIT) quando possível
- [ ] Monitoramento reforçado está ativo para contas admin

### Referências

OWASP ASVS V4.3, NIST 800-53 AC-6, CIS Benchmarks

---

## 26. Privacidade e Minimização de Dados

### Perguntas-chave para o usuário

- Quais dados pessoais são coletados e por quê?
- Existe política de retenção e descarte?
- Dados são anonimizados quando possível?
- Como são tratadas solicitações de exclusão (LGPD/GDPR)?

### O que avaliar

- Minimização: coletar apenas dados necessários para a finalidade declarada
- Finalidade: cada dado coletado tem justificativa documentada
- Retenção: política definida de quanto tempo dados são mantidos, com descarte automático
- Anonimização/pseudonimização: dados que não precisam identificar o titular são anonimizados
- Direitos do titular: mecanismo para exclusão, portabilidade e acesso (LGPD Art. 18, GDPR Art. 15-20)
- Consentimento: coleta com base legal adequada (consentimento, legítimo interesse, etc.)
- Privacy by Design: privacidade considerada desde a arquitetura, não como retrofit
- Inventário de dados: mapa de onde cada tipo de dado pessoal está armazenado

### Resultado esperado

Arquitetura orientada a necessidade real, com minimização de dados,
retenção definida e mecanismos de exercício de direitos.

### Critérios de aceite

- [ ] Apenas dados necessários são coletados (justificativa documentada)
- [ ] Política de retenção e descarte está implementada com automação
- [ ] Dados são anonimizados/pseudonimizados quando possível
- [ ] Mecanismo de exclusão de dados atende LGPD/GDPR
- [ ] Inventário de dados pessoais está documentado
- [ ] Base legal para cada coleta está definida
- [ ] Privacy impact assessment foi realizado

### Referências

LGPD, GDPR, OWASP ASVS V8, NIST Privacy Framework

---

## 27. Integrações Externas

### Perguntas-chave para o usuário

- Quais serviços de terceiros estão integrados?
- Como webhooks são autenticados e validados?
- OAuth é usado? Com quais escopos?
- Existe fallback/isolamento quando um fornecedor falha?

### O que avaliar

- Autenticação de webhooks: assinatura de payload (HMAC-SHA256), verificação em toda requisição
- OAuth: escopos mínimos necessários, tokens com expiração, refresh seguro
- Timeout e retry: configurações defensivas, circuit breaker para evitar cascading failure
- Assinatura de payload: toda comunicação entre serviços verifica integridade (HMAC, JWT assinado)
- Escopo mínimo: permissões solicitadas são o mínimo necessário
- Isolamento de falha: falha de um fornecedor não derruba a aplicação (graceful degradation)
- Validação de dados: dados recebidos de terceiros são tratados como untrusted input
- Monitoramento: chamadas a terceiros são logadas e monitoradas (latência, erros, volume)
- Revisão de fornecedores: avaliação periódica de postura de segurança dos parceiros

### Resultado esperado

Integração controlada, autenticada, validada e observável, com
isolamento de falha e escopo mínimo.

### Critérios de aceite

- [ ] Webhooks são autenticados via assinatura de payload (HMAC)
- [ ] OAuth usa escopos mínimos necessários
- [ ] Timeouts estão configurados para todas as chamadas externas
- [ ] Circuit breaker está implementado para integrações críticas
- [ ] Dados de terceiros são validados como untrusted input
- [ ] Chamadas a terceiros são logadas e monitoradas
- [ ] Falha de fornecedor não derruba a aplicação

### Referências

OWASP ASVS V13, NIST SSDF PW.4

---

## 28. Hardening de Infraestrutura

### Perguntas-chave para o usuário

- Qual é a infraestrutura (cloud, on-prem, containers, serverless)?
- Firewall e WAF estão configurados?
- Containers usam imagem base mínima?
- Existe política de patching?

### O que avaliar

- Firewall: regras restritivas, deny by default, apenas portas necessárias abertas
- WAF: Web Application Firewall protegendo contra OWASP Top 10 (SQLi, XSS, etc.)
- Segmentação de rede: componentes em subnets/VPCs distintas conforme sensibilidade
- Headers de segurança: HSTS, CSP, X-Content-Type-Options, X-Frame-Options, Permissions-Policy
- DDoS: proteção em nível de rede e aplicação (CloudFlare, AWS Shield, etc.)
- Containers: imagem base mínima (distroless/alpine), sem root, read-only filesystem
- Patching: política definida de atualização de OS, runtime e dependências de infraestrutura
- SSH/RDP: acesso restrito, chaves em vez de senhas, bastion host
- Cloud: seguir CIS Benchmarks para o provider (AWS, GCP, Azure)
- Least privilege: IAM roles com permissões mínimas

### Resultado esperado

Base operacional endurecida com firewall restritivo, WAF, containers
mínimos, patching regular e segmentação de rede.

### Critérios de aceite

- [ ] Firewall com deny by default está configurado
- [ ] WAF está ativo e protege contra OWASP Top 10
- [ ] Rede está segmentada (componentes em subnets distintas)
- [ ] Headers de segurança estão configurados (HSTS, CSP, etc.)
- [ ] Proteção DDoS está ativa
- [ ] Containers usam imagem mínima e rodam sem root
- [ ] Política de patching está definida com SLA
- [ ] IAM roles seguem princípio do menor privilégio

### Referências

CIS Benchmarks, OWASP ASVS V14, NIST 800-123

---

## 29. Segurança de IA e Prompts

### Perguntas-chave para o usuário

- A aplicação usa LLMs ou modelos de IA?
- Usuários podem fornecer input que é usado como prompt?
- O modelo tem acesso a dados sensíveis ou ferramentas (tool use)?
- Existe isolamento de contexto entre tenants?

### O que avaliar

- Prompt injection: input do usuário pode manipular instruções do sistema (direct e indirect injection)
- Exfiltração via contexto: modelo pode ser instruído a revelar dados do contexto ou system prompt
- Tool abuse: se o modelo tem acesso a ferramentas (APIs, banco), pode ser manipulado para executar ações indevidas
- Isolamento por tenant: contexto, histórico e dados de um tenant não vazam para outro
- Logs e histórico: conversas e prompts são logados de forma segura, sem exposição indevida
- Guardrails: filtros de input e output para prevenir conteúdo malicioso ou sensível
- Escopo limitado: modelo tem acesso apenas aos dados e ferramentas necessários (PoLP para IA)
- Alucinação: respostas do modelo não são tratadas como verdade absoluta em fluxos críticos
- Rate limiting: proteção contra abuso de endpoints de IA (custo e segurança)
- Data retention: política de retenção de prompts e respostas

### Resultado esperado

Arquitetura de IA com guardrails, escopo limitado, isolamento por tenant
e proteção contra prompt injection e tool abuse.

### Critérios de aceite

- [ ] Input do usuário é sanitizado antes de ser inserido em prompts
- [ ] System prompt não é revelável por manipulação do usuário
- [ ] Ferramentas acessíveis ao modelo seguem princípio do menor privilégio
- [ ] Contexto e histórico são isolados por tenant
- [ ] Guardrails de input e output estão implementados
- [ ] Respostas do modelo não são tratadas como autorizativas em fluxos críticos
- [ ] Rate limiting protege endpoints de IA
- [ ] Política de retenção de prompts/respostas está definida

### Referências

OWASP LLM Top 10, NIST AI RMF, OWASP AI Security

---

## 30. Critérios Objetivos de Aceite de Segurança

### Propósito

Este domínio não é uma área de segurança em si, mas o mecanismo que transforma
toda a auditoria em um framework reutilizável e verificável.

### O que produzir

Consolidar todos os critérios de aceite dos domínios 1-29 em um checklist
unificado com:

| Domínio | Critério | Prioridade | Status | Evidência esperada | Ação corretiva |
|---------|----------|-----------|--------|-------------------|----------------|
| 3       | MFA obrigatório para admins | Crítica | Aprovado/Reprovado | Config de MFA enforcement | Habilitar MFA enforcement |

### Classificação de prioridade

- **Crítica**: falha representa risco de comprometimento imediato
- **Alta**: exploração provável em cenário realista de ataque
- **Média**: melhoria significativa de maturidade de segurança
- **Baixa**: boa prática desejável, sem risco imediato

### Uso do checklist

- Como gate de release: nenhum deploy para produção com critérios críticos reprovados
- Como baseline para novos projetos: aplicar desde o início
- Como input para pentest: direcionar testes para lacunas identificadas
- Como evidência para stakeholders: demonstrar nível de maturidade
- Como ferramenta de acompanhamento: re-avaliar periodicamente

### Resultado esperado

Framework de aceite reutilizável, verificável e aplicável em qualquer
projeto, transformando a auditoria em instrumento operacional contínuo.

### Critérios de aceite (meta)

- [ ] Checklist consolidado cobre todos os 29 domínios
- [ ] Cada critério tem prioridade, status, evidência esperada e ação corretiva
- [ ] Critérios críticos são tratados como gates de release
- [ ] Checklist é revisado e atualizado pelo menos semestralmente
- [ ] Resultados são comunicados a stakeholders relevantes

### Referências

OWASP ASVS (checklist), NIST SSDF (práticas), ISO 27001 (gestão)
