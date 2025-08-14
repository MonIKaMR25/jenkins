# Usamos la imagen lts
FROM jenkins/jenkins:lts

# Usamos la imagen docker:dind y copias el binario a /usr/local/bin
COPY --from=docker:dind /usr/local/bin/docker /usr/local/bin

# Cambiamos de usuario a root para poder agregar al usuario jenkins al grupo root
USER root

# Agregamos al usuario jenkins al grupo root

# Instalar SonarScanner
RUN apt-get update && \
	apt-get install -y unzip wget && \
	wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
	unzip sonar-scanner-cli-5.0.1.3006-linux.zip && \
	mv sonar-scanner-5.0.1.3006-linux /opt/sonar-scanner && \
	ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
	rm sonar-scanner-cli-5.0.1.3006-linux.zip && \
	groupadd docker || true && usermod -aG docker jenkins

# Volvemos a cambiar al usuario jenkins
USER jenkins