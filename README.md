# DadosBr - Consultor de Dados Brasileiros

Um aplicativo mobile multiplataforma desenvolvido com Flutter para consultar dados brasileiros públicos. Busque informações sobre CEP (endereços), CNPJ (empresas) e domínios de internet.

## 📱 Funcionalidades

- **Busca de CEP**: Digite um CEP e obtenha o endereço completo (city, estado, bairro, rua)
- **Busca de CNPJ**: Pesquise uma empresa pelo CNPJ e veja seus dados cadastrais
- **Busca de Domínio**: Verifique informações de registro de domínios

## 🚀 Começando

### Pré-requisitos

Antes de começar, certifique-se de que você tem instalado:

- **Flutter SDK** 3.11.0 ou superior ([Download](https://flutter.dev/docs/get-started/install))
- **Dart** 3.11.0 ou superior (vem com Flutter)
- **Git** ([Download](https://git-scm.com/))
- **Android Studio** (para desenvolver/compilar para Android) ([Download](https://developer.android.com/studio))
- **Xcode** (para desenvolver/compilar para iOS - apenas macOS) ([Download](https://developer.apple.com/xcode/))
- **Espaço em disco**: Aproximadamente 5GB livres

### Verificar instalação

Para verificar se tudo está instalado corretamente, abra o terminal e execute:

```bash
flutter doctor
```

Este comando mostrará o estado de todas as dependências. Tudo deve estar com um ✓ verde.

## 📥 Instalação e Setup Local

### Passo 1: Clonar o repositório

```bash
git clone https://github.com/seu-usuario/dadosbr.git
cd dadosbr
```

### Passo 2: Baixar dependências

```bash
flutter pub get
```

Este comando baixará todas as bibliotecas do Dart/Flutter necessárias.

### Passo 3: Verificar setup (importante!)

```bash
flutter doctor
```

Verifique se não há nenhum erro crítico. Alguns avisos sobre emuladores ou dispositivos podem ser ignorados.

### Passo 4: Conectar dispositivo ou abrir emulador

**Opção A: Usar um dispositivo Android/iOS físico**
- Conecte seu smartphone via USB
- Ative "Depuração USB" nas configurações do telefone
- Execute `flutter devices` para verificar se é reconhecido

**Opção B: Usar um emulador**

Para Android:
```bash
flutter emulators
flutter emulators launch [nome-do-emulador]
```

Para iOS (apenas macOS):
```bash
open -a Simulator
```

### Passo 5: Rodar o app

Com o device/emulador conectado:

```bash
flutter run
```

O app abrirá automaticamente! 🎉

**Dicas:**
- Use `flutter run -v` para ver logs detalhados
- Use `r` para hot-reload (recarregar sem perder estado)
- Use `R` para restart (reiniciar do zero)
- Aperte `q` para sair

## 📦 Como Gerar um APK

### O que é APK?

APK é o formato de arquivo usado para distribuir e instalar apps no Android. É o equivalente ao EXE no Windows.

### Pré-requisitos adicionais para APK

- Android SDK 21 ou superior (geralmente vem com Android Studio)
- Gradle (vem automaticamente com o projeto)
- Aproximadamente 2GB de espaço livre

### Gerando um APK Release

Execute este comando:

```bash
flutter build apk --release
```

**O que acontece:**
1. Flutter compila o código Dart para código máquina
2. Empacota tudo em um arquivo APK
3. O processo leva cerca de 3-5 minutos (primeira vez é mais lenta)

### Localizando o APK gerado

Após o build completar com sucesso, seu APK estará em:

```
build/app/outputs/apk/release/app-release.apk
```

### Instalando o APK em um dispositivo

**Opção 1: Via adb (recomendado)**

```bash
flutter install
```

Ou manualmente:

```bash
adb install build/app/outputs/apk/release/app-release.apk
```

**Opção 2: Via transferência de arquivo**

- Copie o arquivo `app-release.apk` para seu telefone
- Abra o arquivo no telefone
- Siga as instruções para instalar

### Solução de problemas comuns

| Problema | Solução |
|----------|---------|
| `Gradle build failed` | Execute `flutter clean` e tente novamente |
| `Android SDK not found` | Verifique se Android Studio está instalado e execute `flutter doctor -v` |
| `Permission denied` | Permissões USB não ativadas no telefone |
| `APK não instala` | Desinstale versão anterior: `adb uninstall com.example.dadosbr` |

## 📁 Estrutura do Projeto

```
dadosbr/
├── lib/                           # Código Dart principal
│   ├── app_widget.dart            # Widget raiz do app
│   ├── core/                      # Código compartilhado
│   │   ├── constants/             # Constantes (URLs de API, etc)
│   │   ├── ds/                    # Design System (temas, cores, componentes)
│   │   ├── errors/                # Tratamento de erros customizado
│   │   └── state/                 # Estado global (ViewState)
│   ├── modules/                   # Módulos de funcionalidade
│   │   ├── cep/                   # Feature: Busca de CEP
│   │   ├── cnpj/                  # Feature: Busca de CNPJ
│   │   ├── domain/                # Feature: Busca de Domínio
│   │   └── home/                  # Tela inicial
│   └── routes/                    # Configuração de navegação
├── test/                          # Testes automatizados
│   └── modules/                   # Testes de cada módulo
├── android/                       # Código específico do Android (Gradle, manifesto)
├── ios/                           # Código específico do iOS
├── pubspec.yaml                   # Dependências do projeto
└── analysis_options.yaml          # Configuração de linting

```

### Estrutura de cada módulo (ex: cep/)

```
modules/cep/
├── cep_module.dart                # Injeção de dependências
├── models/
│   └── cep_model.dart             # Estrutura de dados
├── repositories/
│   └── cep_repository.dart        # Lógica de apresentação de dados
├── services/
│   └── cep_service.dart           # Chamadas de API
├── viewmodels/
│   └── cep_viewmodel.dart         # Gerenciamento de estado
├── view/
│   └── cep_view.dart              # Tela (UI)
└── widgets/
    └── search_input_widget.dart   # Componentes reutilizáveis
```

## 🏗️ Decisões Técnicas e Arquitetura

### 1. Framework: Flutter + Dart

**Por quê?**
- Um único código compila para Android, iOS, macOS e Linux
- Performance nativa em todas as plataformas
- Desenvolvimento rápido com hot-reload
- Grande comunidade e suporte

### 2. Arquitetura: Clean Architecture

A aplicação segue o padrão **Clean Architecture**, que separa o código em camadas bem definidas:

```
┌─────────────────────────────────────┐
│           TELA (VIEW)               │ ← Exibe informações ao usuário
├─────────────────────────────────────┤
│  GERENCIADOR DE ESTADO (VIEWMODEL)  │ ← Controla lógica da tela
├─────────────────────────────────────┤
│  REPOSITÓRIO (REPOSITORY)           │ ← Busca dados de qualquer fonte
├─────────────────────────────────────┤
│  SERVIÇO (SERVICE)                  │ ← Fala com API externa
└─────────────────────────────────────┘
```

**Benefícios:**
- **Testabilidade**: Cada camada pode ser testada isoladamente
- **Manutenibilidade**: Fácil encontrar onde uma funcionalidade está implementada
- **Reutilização**: Código é reutilizável entre diferentes telas
- **Independência**: Mudanças na API não afetam a UI

**Fluxo de dados:**

```
1. Usuário digita CEP e aperta botão
       ↓
2. View captura a entrada e chama ViewModel
       ↓
3. ViewModel chama Repository passando o CEP
       ↓
4. Repository chama Service
       ↓
5. Service faz requisição HTTP à API BrasilAPI
       ↓
6. Resposta volta para Repository → ViewModel → View
       ↓
7. View exibe os dados ou uma mensagem de erro
```

### 3. Gerenciamento de Estado: ValueNotifier + ViewState

**Como funciona:**

```dart
// ViewModel notifica a View quando há mudanças
final stateNotifier = ValueNotifier<ViewState<CepModel>>(IdleState());

// View observa as mudanças e reconstrói automaticamente
ValueListenableBuilder(
  valueListenable: viewModel.stateNotifier,
  builder: (context, ViewState state, _) {
    if (state is LoadingState) return LoadingWidget();
    if (state is SuccessState) return DataWidget(state.data);
    if (state is ErrorState) return ErrorWidget(state.exception);
    return InitialWidget();
  },
);
```

**Estados possíveis:**

1. **IdleState**: Estado inicia - nada mostrado ainda
2. **LoadingState**: Carregando dados - mostra spinner
3. **SuccessState**: Sucesso - exibe os dados
4. **ErrorState**: Erro - mostra mensagem de erro

### 4. Injeção de Dependências: get_it

**O problema que resolve:**

Imagina que você tem uma classe que precisa:
- De um http client
- De um repositório que usa o http client
- De um viewmodel que usa o repositório
- De uma tela que usa o viewmodel

Sem injeção de dependências, você teria que:

```dart
// ❌ Ruim: acoplamento
final httpClient = DioClient();
final service = CepService(httpClient);
final repository = CepRepository(service);
final viewmodel = CepViewmodel(repository);
final view = CepView(viewmodel);
```

Com `get_it`:

```dart
// ✅ Bom: desacoplado
getIt.registerLazySingleton(() => DioClient());
getIt.registerLazySingleton(() => CepService(getIt()));
getIt.registerLazySingleton(() => CepRepository(getIt()));
getIt.registerFactory(() => CepViewmodel(getIt()));

// Na View, só pega o ViewModel:
final viewmodel = getIt<CepViewmodel>();
```

**Vantagens:**
- Fácil fazer testes (substitui as dependências por mocks)
- Código mais organizado
- Mudanças em dependências afetam só um lugar

### 5. Organização em Módulos

O projeto é dividido em módulos independentes:

```
- home/      → Tela inicial
- cep/       → Feature completa de CEP (UI + lógica + testes)
- cnpj/      → Feature completa de CNPJ
- domain/    → Feature completa de Domínio
- core/      → Código compartilhado (erros, design system, etc)
```

**Por quê?**
- Cada desenvolvedor pode trabalhar em um módulo diferente
- Adicionar novas features é copiar um módulo existente
- Testes ficam organizados junto com o código

## 📚 Bibliotecas Utilizadas

### Dependências Principais

| Biblioteca | Versão | Propósito |
|-----------|--------|----------|
| **dio** | 5.9.1 | Cliente HTTP para fazer requisições à API |
| **result_dart** | 2.1.1 | Tratamento funcional de erros (Result/Either) |
| **get_it** | 9.2.1 | Service Locator para injeção de dependências |
| **brasil_fields** | 1.18.0 | Validação e formatação de campos brasileiros (CEP, CNPJ) |
| **intl** | 0.20.2 | Internacionalização e formatação de datas/números |
| **cupertino_icons** | 1.0.8 | Ícones padrão do iOS/Flutter |
| **flutter_launcher_icons** | 0.14.4 | Gera ícone do app automaticamente |

### Dependências de Desenvolvimento

| Biblioteca | Propósito |
|-----------|----------|
| **flutter_test** | Framework para testes automatizados |
| **mocktail** | Cria mocks de classes para testes |
| **flutter_lints** | Regras de análise estática de código |

### Por que cada uma?

- **dio**: Simples, rápido e com suporte a interceptors (útil para autenticação)
- **result_dart**: Segurança de tipo - erros precisam ser tratados explicitamente
- **get_it**: Padrão da indústria, fácil de aprender
- **brasil_fields**: Evita reinventar a roda com validação de CNPJ/CEP
- **intl**: Suporte a português e formatação de dados

## 🌐 APIs Utilizadas

O projeto consome dados da **BrasilAPI** - uma API pública e gratuita:

**Base URL:** `https://brasilapi.com.br/api`

### Endpoints

#### 1. CEP - Buscar endereço por CEP

```
GET /api/cep/v1/{cep}

Exemplo:
GET /api/cep/v1/01310100

Resposta:
{
  "cep": "01310-100",
  "state": "SP",
  "city": "São Paulo",
  "neighborhood": "Centro",
  "street": "Avenida Paulista"
}
```

#### 2. CNPJ - Buscar dados da empresa

```
GET /api/cnpj/v1/{cnpj}

Exemplo:
GET /api/cnpj/v1/34028316000152

Resposta:
{
  "cnpj": "34.028.316/0001-52",
  "name": "Empresa Exemplo LTDA",
  "status": "ATIVA",
  "address": {...}
}
```

#### 3. Domínio - Buscar registro

```
GET /api/registrobr/v1/{domain}

Exemplo:
GET /api/registrobr/v1/example.com.br
```

## 🧪 Testes

O projeto inclui testes automatizados para garantir qualidade do código.

### Rodando testes

```bash
# Rodar todos os testes
flutter test

# Rodar testes com cobertura
flutter test --coverage

# Rodar testes de um arquivo específico
flutter test test/modules/cep/services/cep_service_test.dart
```

### Estrutura de testes

```
test/modules/
├── cep/
│   ├── services/
│   │   └── cep_service_test.dart          # Testa requisições HTTP
│   ├── repositories/
│   │   └── cep_repository_test.dart       # Testa lógica de dados
│   └── viewmodels/
│       └── cep_viewmodel_test.dart        # Testa estado da tela
└── cnpj/
    └── ... (mesma estrutura)
```

### Exemplo de teste

```dart
void main() {
  group('CepService', () {
    late CepService sut;
    late MockDio mockDio;

    setUp(() {
      mockDio = MockDio();
      sut = CepService(mockDio);
    });

    test('deve retornar um CepModel quando a requisição é bem-sucedida', () async {
      // Arrange (preparar)
      final json = {'cep': '01310-100', 'city': 'São Paulo'};
      when(() => mockDio.get(any()))
          .thenAnswer((_) async => Response(data: json, statusCode: 200));

      // Act (agir)
      final result = await sut.getAddressByCep('01310100');

      // Assert (verificar)
      expect(result.data, isA<CepModel>());
      verify(() => mockDio.get('https://brasilapi.com.br/api/cep/v1/01310100'))
          .called(1);
    });
  });
}
```

## 🎨 Design System

O app usa **Material Design 3** com tema customizado.

### Cores principais

- **Verde primário**: Cor de destaque do app
- **Branco**: Background
- **Cinza**: Textos secundários

### Componentes reutilizáveis

- **SearchInputWidget**: Campo de busca com ícone
- **AppExceptionWidget**: Exibe mensagens de erro
- **LoadingWidget**: Spinner de carregamento

## ⚠️ Tratamento de Erros

O app trata diferentes tipos de erro:

```
ValidationException
├─ CEP inválido (deve ter 8 dígitos)
└─ CNPJ inválido

NotFoundException
├─ CEP não encontrado
└─ CNPJ não encontrado

ServerException
└─ Erro 500 na API

NetworkException
└─ Sem conexão com internet

TimeoutException
└─ Requisição demorou muito
```

Quando um erro ocorre:
1. É capturado pelo Service
2. Convertido para uma exceção customizada
3. Passado para o ViewModel
4. Exibido na tela como mensagem amigável

## 📖 Recursos Adicionais

- [Documentação Flutter](https://flutter.dev/docs)
- [Documentação Dart](https://dart.dev/guides)
- [BrasilAPI - Documentação](https://brasilapi.com.br/)
- [Clean Architecture no Flutter](https://resocoder.com/flutter-clean-architecture)
- [get_it - Documentação](https://pub.dev/packages/get_it)

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

---

**Dúvidas ou problemas?** Abra uma issue no GitHub ou entre em contato com o mantenedor.

**Versão do projeto:** 1.0.0
