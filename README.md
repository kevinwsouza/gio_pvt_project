# frotalog_gestor_v2

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

Código fonte do aplicativo responsável. Dentre algumas das funcionalidades disponíveis, estão:
- Visualização dos carros da frota.
- Tela de detalhes do respectivo carro com suas informações adicionais.
- Navegação entre as telas para voltar e qual carro deseja obter as informações.

## Detalhes técnicos do projeto
- Desenvolvido em [Dart e Flutter](https://flutter.dev/)
- Utiliza [CLEAN Arquitecture](docs/adr/0001-clean-architecture.md) para organização do código.
- Injeção de dependências [get it](https://pub.dev/packages/get_it)
- Gerencimento de rotas com [go router](https://pub.dev/packages/go_router)
- Gerenciamento de estado com [bloc](https://pub.dev/packages/bloc)
- Conexão HTTP com [http](https://pub.dev/packages/http)
- Captura de imagens utilizando o image network do flutter

## Configuração do ambiente
A **Dart VM** e o **Flutter SDK** precisam estar devidamente instalados, de preferência em sua versão *stable*. Utilize o comando `flutter doctor` para verificar se o ambiente Flutter está devidamente configurado.

Após isso, o comando `flutter pub get` faz a instalação das dependências no projeto e `flutter run` inicia a execução em um dispositivo. Mas antes de rodar o projeto, é necessario conferir as configuraçoes de ambiente seguintes.