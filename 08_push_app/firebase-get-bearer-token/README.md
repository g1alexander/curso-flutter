# Servidor para generar un Bearer Token de Firebase

[Documentación oficial de Firebase](https://firebase.google.com/docs/cloud-messaging/auth-server)

## Pasos

1. Instalar las dependencias

```
npm install
```

2. Obtener el archivo de configuración de Firebase (firebase-admin.json)
3. Levantar el servidor

```
node app
```

---

## example send notification

- url: `https://fcm.googleapis.com/v1/projects/flutter-curso-ac172/messages:send`

```json
{
  "message": {
    "token": "",
    "notification": {
      "title": "Yeahh",
      "body": "holi."
    },
    "data": {
      "hola": "mundo",
      "hello": "world"
    },

    "android": {
      "notification": {
        "image": "https://res.cloudinary.com/dl1k2dee0/image/upload/w_250,h_140,f_webp/v1720472410/courses/nest/banner/nest.jpg"
      }
    },
    "apns": {
      "payload": {
        "aps": {
          "mutable-content": 1
        }
      },
      "fcm_options": {
        "image": "https://res.cloudinary.com/dl1k2dee0/image/upload/w_250,h_140,f_webp/v1720472410/courses/nest/banner/nest.jpg"
      }
    }
  }
}
```
