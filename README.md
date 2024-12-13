README
MeowCoffee App
MeowCoffee es una aplicación diseñada para recetas café (calientes o helados) y postres. Se puede explorar, crear, editar y compartir recetas.

Funcionalidades

1. Inicio (Pantalla Principal: "Main Screen")
Muestra todas las recetas por categorías (Caliente, Helado y Postres) y permite realizar las siguientes acciones:
•	Recetas: 
o	Muestra el nombre de cada receta.
o	Incluye un botón de "Preparación" para ver la receta.

•	Acciones: 
o	Compartir receta: Icono de compartir para enviar la receta.
o	Editar receta: Icono de edición para modificar una receta existente. 
  	Al presionar, se abre una pantalla para realizar cambios en la receta.
  	Botón cancelar: Para descartar los cambios.
  	Botón guardar cambios: Para guardar las modificaciones realizadas.
o	Eliminar Receta: Icono de eliminar para borrar una receta de la lista.

2. Pantalla de búsqueda
•	Barra de Búsqueda: 
o	Campo para ingresar el nombre de la bebida que deseas buscar.

•	Filtro: 
o	Icono al lado de la barra para filtrar las bebidas por nombre.

4. Barra de navegación inferior
La barra inferior permite acceder fácilmente a las principales secciones de la app:
•	Recetas: 
o	Acceso a una lista de recetas prediseñadas de café.

•	Listado recetas: Se muestra una lista de recetas por categoría con su foto. Al presionarla te aparece la preparación.

•	Crear recetas: 
o	Pantalla donde puedes agregar tus propias recetas.
o	Tiene: 
  1.	Nombre de la receta.
  2.	Categoría (Caliente o Helado).
  3.	Ingredientes (selecciona de una lista o agrega nuevos).
  4.	Preparación (pasos detallados de la receta).
  5.	Guardar: La receta creada se agrega automáticamente a la lista de bebidas en la pantalla principal.


•	Comeownidad:  
o	Sección para entregar feedback sobre la aplicación.
o	Envío del feedback al correo del desarrollador.

•	Perfil: 
o	Muestra el nombre y la foto del usuario.

Tecnologías Utilizadas
La aplicación está desarrollada en Flutter. Los principales paquetes y tecnologías implementadas son:

Paquetes:
•	sqflite: Para persistencia de datos local.
•	provider: Manejo del estado.
•	url_launcher: Envío de correos electrónicos y enlaces externos.
•	shared_preferences: Almacenamiento de preferencias de usuario.
•	smooth_page_indicator: Indicadores para carruseles en diálogos.

Persistencia de Datos:
•	Base de datos SQLite para almacenar: 
o	Usuarios.
o	Recetas personalizadas.

Diseño UI:
•	Diseño Responsive para adaptarse a diferentes tamaños de pantalla.
•	Paleta de colores basada en tonos pastel: 
o	Fondo rosado: 0xFFfc98a4.
o	Letras amarillas: 0xFFFef9c2.
o	Fondo verde: 0xFFb1e1a3.

Instalación
1.	Clonar este repositorio: 
2.	https://github.com/pazobii/Proyecto2-Si-.git
3.	Navega al directorio del proyecto: 
4.	cd meowcoffee
5.	Instala las dependencias: 
6.	flutter pub get
7.	Corre la aplicación: 
8.	flutter run
