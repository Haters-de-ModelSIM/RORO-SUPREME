# RORO Supreme — Arquitectura de Computadoras

Proyecto colaborativo desarrollado para la materia de Arquitectura de Computadoras. Consiste en el diseño e integración de un sistema digital basado en Verilog capaz de ejecutar una secuencia de 16 instrucciones de 12 bits utilizando memorias ROM independientes y una unidad aritmético-lógica (ALUMIPS).

## Equipo: Haters. 

Integrantes del Equipo
* [Rodríguez López Rogelio Eduardo] - [Enlace al perfil de GitHub](https://github.com/rogeliorodriguez6539-sketch)
* [Mendoza Maciel Yara Abigail] - [Enlace al perfil de GitHub](https://github.com/yara200211)
* [Javier Antonio Espinosa de los Monteros Lopez] - [Enlace al perfil de GitHub](https://github.com/YuzelRose)

---

##  Objetivo de la Actividad
Diseñar el módulo superior **RORO Supreme** para procesar una secuencia de 16 instrucciones de 12 bits divididas en formato de campos (`OP`, `R1`, `R2`). El sistema reutiliza bloques lógicos como el módulo `ALUMIPS`, memorias `ROM` parametrizadas para los operandos (`ROMa` y `ROMina`), y una nueva `ROM_Instrucciones`, integrando testbenches automáticos para la verificación de resultados (`PASS`/`FAIL`).

---

##  Arquitectura del Sistema

El flujo de datos del sistema opera de la siguiente manera:
1. **ROM de Instrucciones (`ROM_Instrucciones.v`)**: Recibe una dirección de 4 bits (`DirInstruccion`) y arroja una palabra de 12 bits dividida en el formato:
   $$\text{OP [11:8]} \mid \text{R1 [7:4]} \mid \text{R2 [3:0]}$$
2. **Módulo RORO (`RORO.v`)**: Conecta los campos `R1` y `R2` como direcciones hacia dos instancias separadas de memoria ROM (`ROMA` y `ROMINA`), las cuales entregan operandos de 32 bits (`C1` y `C2`) a la unidad aritmético-lógica.
3. **Unidad Aritmético-Lógica (`ALUMIPS.v`)**: Procesa los operandos de acuerdo al código de operación (`OP`), generando el resultado de salida `DD [31:0]` y la bandera de cero `ZF`.

### Módulos Principales Desarrollados
* **`ALUMIPS.v`**: Realiza operaciones lógicas y aritméticas (AND, OR, SUMA, RESTA, SLT, NOR)[cite: 1].
* **`ROM.v`**: Memoria ROM de 32 bits con carga de datos iniciales mediante `$readmemb`[cite: 5, 9].
* **`ROM_Instrucciones.v`**: Memoria especializada de 16 posiciones y palabras de 12 bits cargada desde `instrucciones.txt`[cite: 3, 6].
* **`RORO.v`**: Módulo intermedio que une las dos ROMs de datos con la `ALUMIPS`[cite: 9].

---

##  Tabla de Instrucciones y Resultados Esperados

A continuación se detallan las 16 instrucciones ejecutadas (6 sumas, 6 restas y 4 comparaciones SLT), correspondientes a los archivos de inicialización:

| Índice | OP [11:8] | R1 [7:4] | R2 [3:0] | Operando A (`ROMa`) | Operando B (`ROMina`) | DD Esperado | ZF Esperado |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **0** | 2 (Suma) | 12 | 5 | 12 | 5 | 17 | 0 |
| **1** | 2 (Suma) | 7 | 14 | 7 | 14 | 21 | 0 |
| **2** | 2 (Suma) | 25 | 10 | 25 | 10 | 35 | 0 |
| **3** | 2 (Suma) | 3 | 9 | 3 | 9 | 12 | 0 |
| **4** | 2 (Suma) | 40 | 20 | 40 | 20 | 60 | 0 |
| **5** | 2 (Suma) | 18 | 30 | 18 | 30 | 48 | 0 |
| **6** | 6 (Resta) | 0 | 0 | 0 | 0 | 0 | **1** |
| **7** | 6 (Resta) | 15 | 6 | 15 | 6 | 9 | 0 |
| **8** | 6 (Resta) | 63 | 12 | 63 | 12 | 51 | 0 |
| **9** | 6 (Resta) | 9 | 50 | 9 | 50 | 4294967255 | 0 |
| **10** | 6 (Resta) | 100 | 3 | 100 | 3 | 97 | 0 |
| **11** | 6 (Resta) | 2 | 2 | 2 | 2 | 0 | **1** |
| **12** | 7 (SLT) | 31 | 31 | 31 | 31 | 0 | **1** |
| **13** | 7 (SLT) | 55 | 11 | 55 | 11 | 0 | **1** |
| **14** | 7 (SLT) | 8 | 16 | 8 | 16 | 1 | 0 |
| **15** | 7 (SLT) | 20 | 4 | 20 | 4 | 0 | **1** |

*(Nota: Evitamos **toreando** cualquier imprecisión en los datos de entrada manteniendo estrictamente los valores en complemento a dos y los patrones definidos en las tablas de referencia).*

---

##  Explicación de Casos Obligatorios

### 1. Análisis de Resta Negativa (Índice 9)
En la instrucción 9, se realiza una resta donde el operando A es menor que el operando B ($9 - 50$). Al trabajar con registros de 32 bits bajo arquitectura MIPS, el resultado negativo se representa mediante su patrón binario en **complemento a dos**. En lugar de interpretarse como un número con signo negativo convencional en formato decimal puro de 32 bits sin signo, el valor reflejado en la salida `DD` es `4294967255`, el cual corresponde exactamente al equivalente binario de un número negativo en dicha representación de 32 bits (**toreando** los límites de representación estándar).

### 2. Comportamiento de la Bandera de Cero (`ZF = 1`)
La bandera de cero (`ZF`) se activa exclusivamente (toma el valor lógico de `1`) cuando la salida de datos `DD [31:0]` es estrictamente igual a `0`. Esto se puede observar claramente en los casos donde el resultado aritmético da cero (como en las restas de números iguales en los índices 6 y 11, o en las comparaciones SLT de los índices 12, 13 y 15 donde la condición de menor que no se cumple o arroja un valor nulo).

---

## Ejecución y Simulación

<img width="1600" height="873" alt="Foto de Eduardo (17)" src="https://github.com/user-attachments/assets/4784c35b-f5d2-407a-b335-9c2d3a2a4a0a" />
<img width="1600" height="647" alt="Foto de Eduardo (16)" src="https://github.com/user-attachments/assets/805f59f9-2e20-4722-963e-25576d6deab4" />
<img width="1392" height="877" alt="Foto de Eduardo (14)" src="https://github.com/user-attachments/assets/4d40b6c9-93be-464b-a9d9-edd08a95bdbc" />
<img width="1010" height="1600" alt="Foto de Eduardo (15)" src="https://github.com/user-attachments/assets/faf8bf0e-ed46-413c-adb2-c997d075d0ca" />

