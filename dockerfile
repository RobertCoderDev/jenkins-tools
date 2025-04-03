# Imagen base de Jenkins con soporte para Docker
FROM jenkins/jenkins:lts

# Usuario root para instalar paquetes
USER root

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    nano \
    zip \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Instalar Node.js 20 y Angular CLI
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g @angular/cli

# Verificar versiones instaladas
RUN node -v && npm -v && ng version
RUN apt-get install zip
RUN zip --version

# Volver al usuario Jenkins
USER jenkins

# Configurar el directorio de trabajo
WORKDIR /var/jenkins_home

# Exponer el puerto de Jenkins
EXPOSE 8080

# Comando de inicio
CMD ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]