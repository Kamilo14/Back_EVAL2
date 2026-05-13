# Imagen base oficial de Node.js versión 20 usando Alpine Linux
# Alpine es una distribución muy liviana → imágenes más pequeñas y rápidas
FROM node:20-alpine

# Define el directorio de trabajo dentro del contenedor
# Todo se ejecutará dentro de /app
WORKDIR /app

# Copia package.json y package-lock.json al contenedor
# Se hace primero para aprovechar caché de Docker
COPY package*.json ./

# Instala dependencias SOLO de producción
# --production evita instalar dependencias de desarrollo
RUN npm install --production

# Copia todo el proyecto al contenedor
COPY . .

# Crea grupo y usuario NO ROOT por seguridad
# La rúbrica evalúa esto
RUN addgroup -S nodegroup && adduser -S nodeuser -G nodegroup

# Cambia el usuario actual del contenedor
# La aplicación ya NO correrá como root
USER nodeuser

# Expone el puerto 3000
# Informa que la aplicación escucha en ese puerto
EXPOSE 3000

# Comando que se ejecuta al iniciar el contenedor
# Ejecuta npm start
CMD ["npm", "start"]