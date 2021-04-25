# WellTodoMovies
Replica parcial do aplicativo [TodoMovies](https://apps.apple.com/br/app/todomovies-4/id792499896) usando a [API do The Movie DB](https://developers.themoviedb.org/3/getting-started/introduction).

### Informações do Projeto
* Tempo de Desenvolvimento: 31 horas e 44 minutos
* Design Pattern: MVVM-C
* Gerenciador de Dependência: CocoaPods
* Frameworks: Alamofire e Moya para as chamadas de API e Kingfisher para carregamento de imagens.

### Erros Conhecidos
* Servidor retorna resultado inválido na API _Get Similar Movies_. Ao requisitar pela página 1, é retornado um vetor de filmes corretamente, porém, ao requisitar pelas páginas seguintes, é retornado o mesmo vetor da página anterior na mesma ordem. Tentei executar a requisição em diversos ambientes diferentes e o resultado é sempre o mesmo. De qualquer forma, a aplicação possui suporte a paginação, porém, para o não estranhamento ao ser executado, a feature está bloqueada e para poder ser testada é preciso descomentar a linha 135 do arquivo [MovieDetailsViewModel.swift](/WellTodoMovies/Scenes/Movie/Details/MovieDetailsViewModel.swift).
