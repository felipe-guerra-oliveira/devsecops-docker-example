# Containêres Docker
Bem-vindo ao projeto de exemplo de Docker containêres!
Aqui você verá como executar o seguinte container Docker à partir do arquivo Dockerfile na raiz do projeto.

## Build
Primeiramente, é necessário realizar o build do arquivo Dockerfile:

```
docker build -f Dockerfile -t springboot-api .
```

## Run
Em seguida, vamos executar o container gerado e subir a aplicação que está embarcada:

```
docker run -d -p 8000:8000 springboot-api
```

Se o comando rodou com sucesso, então valide o resultado assim:

```
docker % docker ps -a
```

Provavelmente, você verá o log da execução que mostra o status* igual a UP:

```
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS          PORTS                    NAMES
dad4ffcf10ba   springboot-api   "java -jar simple-sp…"   37 seconds ago   Up 37 seconds   0.0.0.0:8000->8000/tcp   trusting_mcnulty
```

## Test
Em seguida, acesse no browser a URL da aplicação, validando que ela responde corretamente: 
http://localhost:8000/ping

## Logging
Se desejar, verifique os lgs gerados pela execução do container:

```
docker logs <container_id>
```

Resultado esperado:

```
Picked up JAVA_TOOL_OPTIONS: -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8008
Listening for transport dt_socket at address: 8008

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/

 :: Spring Boot ::             (v3.5.0-M3)

2025-03-26T19:47:13.979Z  INFO 1 --- [simple-springboot-api] [           main] b.c.i.a.s.SimpleSpringbootApiApplication : Starting SimpleSpringbootApiApplication v0.0.1-SNAPSHOT using Java 17.0.14 with PID 1 (/app/simple-springboot-api-0.0.1-SNAPSHOT.jar started by appuser in /app)
2025-03-26T19:47:13.998Z  INFO 1 --- [simple-springboot-api] [           main] b.c.i.a.s.SimpleSpringbootApiApplication : No active profile set, falling back to 1 default profile: "default"
2025-03-26T19:47:16.344Z  INFO 1 --- [simple-springboot-api] [           main] o.s.b.w.e.t.TomcatWebServer              : Tomcat initialized with port 8000 (http)
2025-03-26T19:47:16.378Z  INFO 1 --- [simple-springboot-api] [           main] o.a.c.c.StandardService                  : Starting service [Tomcat]
2025-03-26T19:47:16.378Z  INFO 1 --- [simple-springboot-api] [           main] o.a.c.c.StandardEngine                   : Starting Servlet engine: [Apache Tomcat/10.1.39]
2025-03-26T19:47:16.440Z  INFO 1 --- [simple-springboot-api] [           main] o.a.c.c.C.[.[.[/]                        : Initializing Spring embedded WebApplicationContext
2025-03-26T19:47:16.443Z  INFO 1 --- [simple-springboot-api] [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 2342 ms
2025-03-26T19:47:17.682Z  INFO 1 --- [simple-springboot-api] [           main] o.s.b.a.e.w.EndpointLinksResolver        : Exposing 1 endpoint beneath base path '/actuator'
2025-03-26T19:47:17.819Z  INFO 1 --- [simple-springboot-api] [           main] o.s.b.w.e.t.TomcatWebServer              : Tomcat started on port 8000 (http) with context path '/'
2025-03-26T19:47:17.839Z  INFO 1 --- [simple-springboot-api] [           main] b.c.i.a.s.SimpleSpringbootApiApplication : Started SimpleSpringbootApiApplication in 5.119 seconds (process running for 7.109)
2025-03-26T19:49:29.293Z  INFO 1 --- [simple-springboot-api] [nio-8000-exec-1] o.a.c.c.C.[.[.[/]                        : Initializing Spring DispatcherServlet 'dispatcherServlet'
2025-03-26T19:49:29.293Z  INFO 1 --- [simple-springboot-api] [nio-8000-exec-1] o.s.w.s.DispatcherServlet                : Initializing Servlet 'dispatcherServlet'
2025-03-26T19:49:29.294Z  INFO 1 --- [simple-springboot-api] [nio-8000-exec-1] o.s.w.s.DispatcherServlet                : Completed initialization in 0 ms
```

## Docker Swarm

Para utilizar o recurso de alta disponibilidade, em sua máquina local, iremos rodar a aplicação com o Swarm, utilizando a quantidade de réplicas como parâmetro.

Exemplo:

Caso o serviço não esteja iniciado:

```
docker swarm init
```

A seguir, execute o comando:

```
docker service create --name springboot-api-ha  --replicas 3 -p 8000:8000 springboot-api
```

Resultado esperado:

```
image springboot-api:latest could not be accessed on a registry to record
its digest. Each node will access springboot-api:latest independently,
possibly leading to different nodes running different
versions of the image.

pqv9xpicynnci0h4gqhkipumv
overall progress: 3 out of 3 tasks 
1/3: running   [==================================================>] 
2/3: running   [==================================================>] 
3/3: running   [==================================================>] 
verify: Service pqv9xpicynnci0h4gqhkipumv converged 
```

Para testar, acesse a URL do serviço no browser: http://localhost:8000/ping