# Alohomora 🪄
Alohomora é um aplicativo iOS nativo que consome dados do universo de Harry Potter para listar personagens, feitiços e gerenciar um baú de favoritos. O projeto foi desenvolvido com foco em alta testabilidade, isolamento de responsabilidades e escalabilidade.

## 🛠️ Arquitetura e Padrões de Projeto
O projeto foi construído seguindo os princípios do SOLID e do desenvolvimento limpo:
- Clean Architecture + MVVM: Separação clara em três camadas independentes:
  - Data: Responsável pelo consumo de rede (APIClient) e persistência.
  - Domain: Contém as regras de negócio puras (Entities, contratos de Repositories e UseCases).
  - Presentation: Controla a UI usando o padrão MVVM com View Code.
- Coordinator Pattern: Toda a navegação do aplicativo é centralizada e controlada por camadas de fluxo (Coordinators), removendo o acoplamento de navegação de dentro das ViewControllers.
- Abstract Factories & Injeção de Dependência: A inicialização e acoplamento das ViewModels, UseCases e Controllers da camada de apresentação são resolvidos através de factories, facilitando o uso de mocks nos testes unitários.

## 🚀 Tecnologias e Funcionalidades Core
- API Principal: Consumo de dados assíncrono através da Harry Potter API.
- Navegação por TabBar: Uma UITabBarController centraliza o acesso às seções principais do aplicativo organizadas por sub-fluxos coordenados.
- Gerenciamento de Imagens Assíncrono (ImageLoader): Serviço customizado para download de imagens usando URLSession com política de cache em memória nativa via NSCache para otimização de performance e rede.
- Armazenamento Local: Uso de UserDefaults encapsulado em repositório específico para persistir os itens salvos no baú.
- UX por Long Press: A ação de favoritar ou remover um item do baú (Trunk) é disparada intuitivamente através de um gesto de toque longo na célula da lista.
- Extensões Reutilizáveis: Comportamentos visuais compartilhados e customizações (como paleta de cores e animações de feedback) foram isolados em extensões utilitárias (Utils) para maximizar o reaproveitamento de código.

## 📂 Estrutura do Projeto
```text
alohomora
├── App
├── Data
│   ├── Network (APIClient, DTOs, Requests)
│   ├── Repositories (Implementações concretas)
│   └── Services (ImageLoader Cache)
├── Domain
│   ├── Entities (Modelos puros)
│   ├── Repositories (Interfaces/Protocolos)
│   └── UseCases (Regras de negócio de favoritos e listagens)
├── Presentation
│   ├── Coordinators (Orquestração de fluxo de tela)
│   ├── Home / Spellbook / Trunk (Módulos MVVM + Factories)
│   └── TabBar (Navegação base)
└── Utils (Extensões de UIKit e Foundation)

### 📌 Status do Desenvolvimento
⚠️ Nota: A estrutura arquitetural e as abas de Home, Spellbook e Trunk estão 100% operacionais. A aba correspondente ao Chapéu Seletor (Sorting Hat) consta na barra de navegação para fechamento de escopo de layout, porém sua lógica de negócio interna não foi implementada ainda.
