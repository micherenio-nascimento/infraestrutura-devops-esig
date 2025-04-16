# Infraestrutura devops esig

#### Criar uma imagem Docker:
```bash
docker build -t jenkins-docker .
```

#### Executar o container a partir da imagem criada:
```bash
docker run -d -p 9190:9190 --name jenkins jenkins-docker
```