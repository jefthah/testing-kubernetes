# Gunakan image dasar node untuk membangun aplikasi
FROM node:14 AS build

# Set direktori kerja
WORKDIR /app

# Salin package.json dan package-lock.json
COPY package*.json ./

# Instal dependensi
RUN npm install

# Salin sisa kode aplikasi
COPY . .

# Build aplikasi
RUN npm run build

# Gunakan image dasar Nginx untuk menyajikan aplikasi
FROM nginx:alpine

# Salin build output dari tahap build sebelumnya
COPY --from=build /app/build /usr/share/nginx/html

# Ekspose port yang digunakan Nginx
EXPOSE 80

# Jalankan Nginx
CMD ["nginx", "-g", "daemon off;"]
