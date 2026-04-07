<!--
  COMANDO: /project:refactor [arquivo | pasta | componente]
  QUANDO ACIONAR: ao reorganizar código sem alterar comportamento externo.
  QUEM ACIONA: usuário explicitamente.
  ETAPAS: [GENÉRICO]
  - Analisa o código: o que faz, quem depende, qual o problema
  - Apresenta plano e aguarda confirmação
  - Executa em passos incrementais e verificáveis
  - Verifica build, tipagem e testes ao final
  - Atualiza docs se necessário
-->

# /project:refactor $ARGUMENTS

Refatoração estruturada com garantia de comportamento preservado.

---

## Sequência

### 1. Análise [GENÉRICO]

Leia o código que será refatorado.
Identifique:

- O que ele faz hoje
- Quem depende dele (verificar com Grep antes de qualquer mudança)
- Qual o problema atual
- Em qual camada ele está

### 2. Plano [GENÉRICO]

Apresente ao usuário:

- O que será mudado e por quê
- O que NÃO vai mudar (comportamento externo)
- Arquivos afetados
- Riscos identificados

**Aguarde confirmação antes de executar.**

### 3. Execução incremental [GENÉRICO]

Refatore em passos pequenos e verificáveis.
Após cada passo:

- Atualize os consumidores impactados
- Confirme que o comportamento está preservado
- Verifique build, tipagem ou testes quando aplicável

### 4. Verificação final [ADAPTÁVEL]

Confirme que todos os consumidores continuam funcionando.
Verifique especialmente:

- Imports e exports afetados
- Módulos reutilizados em múltiplos lugares
- Contratos de API ou interfaces públicas, se houver

### 5. Documentação [GENÉRICO]

Se a refatoração muda algo documentado, atualize os docs afetados.
Se a mudança for apenas estrutural e a documentação continuar correta,
registre isso no relatório final.
