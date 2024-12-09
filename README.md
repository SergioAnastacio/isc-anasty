[![Terraform and Ansible Pipeline](https://github.com/SergioAnastacio/isc-anasty/actions/workflows/main.yaml/badge.svg)](https://github.com/SergioAnastacio/isc-anasty/actions/workflows/main.yaml)
# ISC Anasty

## Propósito del repositorio
Este repositorio está diseñado para proporcionar soluciones a problemas comunes al implementar una arquitectura en AWS. El objetivo es automatizar y simplificar la configuración de los componentes de infraestructura, asegurando consistencia y eficiencia en el despliegue.

## ¿Qué hace?
El proyecto ISC Anasty utiliza **Terraform** para conectarse al proveedor de AWS y crear los recursos en la nube. Además, crea un inventario de **Ansible** para permitir la configuración de las instancias EC2, instalando Docker, obteniendo la imagen de Docker a utilizar y ejecutándola.

### Funcionalidades clave:
- **VPC (Virtual Private Cloud)**: Configuración de una VPC para aislar recursos de la red.
- **Subnets**: Creación y configuración de subredes dentro de la VPC para segmentar el tráfico.
- **Tablas de Routing**: Definición y asociación de tablas de enrutamiento para controlar la dirección del tráfico en la red.
- **Security Groups**: Configuración de grupos de seguridad para gestionar el acceso y la seguridad de los recursos.
- **Instancias EC2**: Creación de instancias EC2 con Ubuntu, incluyendo la asignación de direcciones IP fijas y su configuración utilizando Ansible.
- **Direcciones** IP Fijas: Asignación y gestión de direcciones IP fijas para las instancias EC2.

## Beneficios

* **Automatización**: Reduce el tiempo y los errores asociados con la configuración manual.
* **Consistencia**: Asegura configuraciones uniformes y repetibles a través de diferentes entornos.
* **Escalabilidad**: Facilita la escalabilidad de la infraestructura a medida que crecen las necesidades del proyecto.
* **Flexibilidad**: Permite ajustes rápidos y personalizados según los requerimientos específicos del proyecto.


## Pasos para utilizarlo
>[!TIP] TIP: Opcionalmente puedes instalar Localmente Terraform y Ansible
1. **Clonar el repositorio**:
    - Si no tienes el CLI de GitHub instalado:
    ```ssh
        git clone https://github.com/SergioAnastacio/isc-anasty.git
    ```
    - Si tienes el CLI de GitHub instalado:
    ```ssh
        gh repo clone SergioAnastacio/isc-anasty
    ```

2. **Configuracion**:  
    >[!TIP] TIP: Recomendamos descargar las credenciales como .csv 
    - Crea un usuario en IAM de AWS para que use el CLI, guarda las claves de **Access Key ID** y **Secret Access Key** 
    - En el repositorio, guarda el contenido de Access Key ID y Secret Access Key en un secreto de GitHub con los nombres **AWS_ACCESS_KEY_ID** y **AWS_SECRET_ACCESS_KEY**.
    - Crea una clave SSH .pem y encripta su contenido en base64. Guarda el contenido en un secreto de GitHub con el nombre **ANSIBLE_PRIVATE_KEY**.
    - Modifica el archivo `const.tf` según tus requerimientos.

3. **Desplegar**: Empuja los cambios con un commit y el pipeline se encargará del resto.
   

## Contribuir

¡Nos encantaría contar con tu colaboración! Si tienes ideas para mejorar el proyecto, descubre un problema, o simplemente quieres aportar al desarrollo, por favor, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama `git checkout -b feature/nueva-caracteristica`.
3. Realiza tus cambios y haz un commit `git commit -m 'Añadir una nueva característica'`.
4. Haz un push a la rama `git push origin feature/nueva-caracteristica`.
5. Abre un Pull Request.

Si tienes alguna pregunta o sugerencia, no dudes en abrir un **issue**. ¡Esperamos tus contribuciones!

### Compartir

Si encuentras útil este proyecto, por favor, compártelo con otros:

- Dale una estrella ⭐ en GitHub.
- Comparte el enlace del repositorio en tus redes sociales.
- Habla sobre el proyecto con tus colegas y amigos.

¡Gracias por tu apoyo!