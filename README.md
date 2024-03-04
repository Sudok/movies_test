
# Movies

Desafio técnico para empresa oxeanbits, visando a criação de métodos para importação em massa de filmes e notas do mesmos!


#### Requisitos

- [ruby-3.1.4](https://www.ruby-lang.org/en/news/2023/03/30/ruby-3-1-4-released/)
- [sqlite3](https://www.sqlite.org/download.html)
- [Docker 25.0.1](https://docs.docker.com/engine/release-notes/25.0/)
- [Redis](https://redis.io/)

### Executando o projeto:

```ruby
bundle install
rails db:migrate
rails db:seed
bundle install
rails server
```

### Alternativa utilizando docker:
Foi configurado um Makefile com os alias para facilitar o setup, só rodar no terminal os comandos listados abaixo na ordem declarada.

```docker
make setup
make start
```
Depois só acessar localhost:3000 e logar utilizando a conta de usuario.

### Rodando testes:
só rodar o comando, e o mesmo já vai executar todos os testes.
```ruby
rspec
```

### Importando filmes em lote

Após logar como usario:
email: admin@rotten
senha: admin

Acesse a tela de criação de [filmes](http://127.0.0.1:3000/movies/new), onde voce irá encontrar o botão para upload de arquivos CSV(existem 2 exemplos na pasta fixtures: spec/fixtures).

### Importando nota dos filmes em lote
Importante lembrar que o passo a cima precisa ser rodado primeiro.

Acesse a [tela principal](http://127.0.0.1:3000/movies/) da aplicaçao, onde os filmes estão listado, e lá voce vai encontrar o botão para import de notas, onde só recebe arquivos do tipo CSV.
