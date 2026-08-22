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

 clear 
 close
 clc
 L1=Revolute('a',20,'alpha',0,'d',0);
 L2=Revolute('a',10,'alpha',0,'d',0);
 bot=SerialLink([L1,L2]);
 bot.fkine([pi/2,0]) %
 bot.links
 bot.teach([pi/2,0], 'noname');
