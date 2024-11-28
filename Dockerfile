FROM maven:3.8.5-openjdk-17 as build
WORKDIR /app
COPY pom.xml .
# Descargar todas las dependencias y -B para omitir las confirmaciones
RUN mvn dependency:go-offline -B
# Copia todo a todo
COPY . .
#Clean pa limpiar todo jeje y package para generar el jar
RUN mvn clean package -DskipTests
# Fin construccion
# Produccion
# JRE
FROM openjdk:17-slim
WORKDIR /app
COPY --from=build /app/target/gpds-autos-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
# CMD ["java","-jar","app.jar"]
ENTRYPOINT ["java","-jar","app.jar"]