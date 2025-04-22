# Étape 1: Construction de l'application avec Maven
FROM maven:3.8-openjdk-17  AS build-stage

# Clone le dépôt Git (remplacez par votre URL)
RUN git clone https://github.com/neezotk/helloworld-springboot.git /app
WORKDIR /app

# Construit l'application et crée le JAR
RUN mvn clean package -DskipTests

# Étape 2: Création de l'image d'exécution
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Copie le JAR depuis l'étape de construction
COPY --from=build-stage /app/target/*.jar app.jar

# Exposition du port (Spring Boot utilise 8080 par défaut)
EXPOSE 8080

# Commande pour lancer l'application
ENTRYPOINT ["java", "-jar", "app.jar"]