# Takoyaki Sushi - Sistema de Gestión de Restaurante

- Takoyaki Sushi es un sistema de gestión diseñado para administrar eficientemente las operaciones de un restaurante. Este proyecto permite gestionar mesas, pedidos, clientes, productos y más.

## Características principales

- Gestión de mesas y reservas.
- Control de pedidos y cuentas.
- Administración de productos, bebidas y combos.
- Interfaz intuitiva y fácil de usar.

## Requisitos

\*Antes de ejecutar el proyecto, asegúrate de tener instalado lo siguiente:

    ** Python 3.8 o superior.
    **MySQL Server configurado y en funcionamiento.
    **Un editor de texto o IDE (por ejemplo, VS Code).

## Instalación

- Instalar dependencias

  > pip install -r requirements.txt

- Configurar credenciales
- Crea un archivo .env en la raíz del proyecto y añade las siguientes variables de entorno con tus credenciales de MySQL:

## Configurar la base de datos

- El archivo database.py ya no se utiliza. Ahora, usa database1.py para configurar la base de datos inicial.

> python -m app.database1

Esto creará las tablas necesarias y cargará los datos iniciales.

## Iniciar el servidor

> uvicorn app.main:app --reload

- El servidor estará disponible en http://127.0.0.1:8000.

- Detener el servidor
- Para detener el servidor, presiona CTRL+C en la terminal donde se está ejecutando.

## Notas importantes

- El archivo database.py está obsoleto y ha sido reemplazado por database1.py.
- Asegúrate de que el archivo .env esté correctamente configurado antes de ejecutar cualquier script.
- Si encuentras algún problema, revisa los logs en la terminal para identificar errores.
