# Parametros de Denavit-Hartenberg y Cinematica

## 1. Objetivos de la Presentación

- Exponer los conceptos básicos de la morfología robótica, incluyendo los tipos de articulaciones, eslabones, y grados de libertad.
- Definir los conceptos fundamentales de espacio alcanzable y espacio de trabajo de un robot.
- Introducir la representación Denavit-Hartenberg (D-H) como un método sistemático para obtener la cinemática directa.
- Demostrar la implementación del modelo cinemático directo de un robot planar de 2 GDL utilizando código en MATLAB.

## 2. Desarrollo y Definición de los Parámetros Denavit-Hartenberg

El método propuesto por Denavit y Hartenberg en 1955 permite describir y representar de forma sistemática la geometría espacial de los elementos de una cadena cinemática (como un robot) con respecto a un sistema de referencia fijo. Este método utiliza una matriz de transformación homogénea de 4x4 que relaciona el extremo del robot con su base. 
Escogiendo adecuadamente los sistemas de coordenadas para cada eslabón, la transición entre uno y el siguiente se logra mediante 4 transformaciones básicas, definidas por 4 parámetros dependientes exclusivamente de las características geométricas del eslabón:

- θi: Es el ángulo que forman los ejes Xi-1 y Xi medido en un plano perpendicular al eje Zi-1. Es un parámetro variable en articulaciones giratorias.
- di: Es la distancia a lo largo del eje Zi-1 desde el origen del sistema i-1 hasta la intersección con el eje Xi. Es un parámetro variable en articulaciones prismáticas
- ai: Es la distancia a lo largo del eje Xi desde la intersección del eje Zi-1 con el eje Xi hasta el origen del sistema i . En articulaciones prismáticas es la distancia más corta entre los ejes Z.
- αi: Es el ángulo de separación entre el eje Zi-1 y el eje Zi, medido en un planoperpendicular al eje Xi.

## 3. Consideraciones Especiales del Método D-H

Para que la asignación de sistemas de coordenadas sea correcta según la convención de Denavit-Hartenberg, es fundamental tener en cuenta las siguientes restricciones geométricas:

- No está permitido desplazarse ni rotar con respecto al eje Y. 
- Los ejes Zi deben coincidir con los ejes de acción de las articulaciones (ya sea rotación o traslación en Z).
- Propiedad de la doble perpendicularidad: Los ejes Xi deben satisfacer estrictamente que Xi ⊥ Zi y simultáneamente Xi ⊥ Zi-1.

## 4. Implementación y Explicación del Código (MATLAB)

El siguiente código modela un robot planar de 2 grados de libertad utilizando un entorno como el Robotics Toolbox:

<img width="650" height="312" alt="image" src="https://github.com/user-attachments/assets/2ffa6096-67f0-469d-85b4-968683687bca" />

### Análisis y funciones línea por línea:

- clear, close, clc: Inicializan el entorno de trabajo. clear limpia el workspace de variables previas, close cierra ventanas de figuras abiertas, y clc limpia la consola de comandos.
  ### Revolute (...): Declara que el eslabón tiene un grado de libertad rotacional. (L1 = Revolute('a',20,'alpha',0,'d',0);)
  Crea los eslabones del robot estableciendo que sus articulaciones son de tipo rotacional (Revolute). Aquí se introducen los parámetros D-H estáticos: las longitudes de los
eslabones a1= 20 y a2= 10(...). Como se trata de un robot planar (movimiento en un solo plano 2D), la torsión (α) y el desfase a lo largo del eje de giro (d) son 0. El parámetro variable en este caso será θ (calculado en las funciones posteriores).

- Para el caso de articulaciones Prismaticas:
#### Prismatic(...) o Pris(...): Declara que el eslabón posee un grado de libertad lineal. (L3 = Prismatic('theta', 0, 'a', 0, 'alpha', -pi/2, 'qlim', [0, 50]); )
- 'theta', 0: A diferencia de la función Revolute donde definíamos d, aquí establecemos theta como un valor fijo (en este caso 0 radianes), ya que la articulación no girará.
- 'qlim', [0, 50]: Este parámetro (límites de la articulación) es fundamental al programar prismáticas. Define la extensión mecánica máxima y mínima del actuador lineal (por ejemplo, un cilindro neumático o un riel que puede desplazarse desde 0 hasta 50 unidades de longitud). Evita que en la simulación el eslabón se extienda hasta el infinito.
  
- bot = SerialLink([L1,L2]);: Une secuencialmente los eslabones definidos (L1 y L2) para construir el objeto del robot completo como una cadena cinemática serial.
- bot.fkine([pi/2,0]): Evalúa la cinemática directa (Forward Kinematics). Al entregarle el vector de coordenadas articulares q = [π/2, 0] (es decir, 90° para la primera articulación y 0° para la segunda), la función retorna la matriz de transformación homogénea que indica la posición y orientación final del extremo del robot.
- bot.links: Despliega en la ventana de comandos un arreglo estructurado (o tabla) que resume los parámetros Denavit-Hartenberg configurados para todos los eslabones de la cadena cinemática.
- bot.teach([pi/2,0], 'noname');: Lanza una interfaz gráfica interactiva (GUI). Esta ventana grafica al robot en la postura inicial definida por los ángulos [π/2, 0] y proporciona controles deslizantes (sliders) para que el usuario pueda mover
manualmente cada articulación y observar el comportamiento cinemático en tiempo real.


