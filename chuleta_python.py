
"""
====================================
 CHULETA DE PYTHON PARA PRINCIPIANTES
====================================

"""
# -------------------------------------------------------------
# VARIABLES Y CADENAS
# -------------------------------------------------------------

# Las variables almacenan valores. Las cadenas (strings) se escriben entre comillas.
mensaje = "Hola mundo!"
print(mensaje)

# Concatenación de cadenas
nombre = 'Albert'
apellido = 'Einstein'
completo = nombre + ' ' + apellido
print(completo)

# f-strings (formato moderno)
print(f"Hola, {nombre} {apellido}!")



# -------------------------------------------------------------
# LISTAS
# -------------------------------------------------------------

# Una lista almacena varios elementos ordenados.
bikes = ['trek', 'redline', 'giant']
print(bikes)

# Acceder a elementos
print(bikes[0])   # Primer elemento
print(bikes[-1])  # Último elemento

# Agregar y eliminar elementos
bikes.append('specialized')
print(bikes)

bikes.remove('redline')
print(bikes)

# Recorrer listas
for bike in bikes:
    print("Me gusta la bicicleta", bike)



# -------------------------------------------------------------
# TUPLAS
# -------------------------------------------------------------

# Las tuplas son como listas, pero inmutables.
dimensiones = (1920, 1080)
print("Resolución:", dimensiones[0], "x", dimensiones[1])



# -------------------------------------------------------------
# DICCIONARIOS
# -------------------------------------------------------------

# Un diccionario guarda pares clave:valor.
alien = {'color': 'verde', 'puntos': 5}
print(alien['color'])

# Agregar nuevos pares
alien['x_pos'] = 0
alien['y_pos'] = 25
print(alien)

# Recorrer diccionarios
for clave, valor in alien.items():
    print(clave, "=>", valor)



# -------------------------------------------------------------
# CONDICIONALES (if / elif / else)
# -------------------------------------------------------------

edad = 18
if edad >= 18:
    print("¡Puedes votar!")
elif edad > 4:
    print("Eres demasiado joven para votar.")
else:
    print("Eres un bebé.")

# Operadores lógicos
x, y = 10, 20
if x < y and y < 50:
    print("Ambas condiciones son verdaderas.")



# -------------------------------------------------------------
# BUCLES WHILE
# -------------------------------------------------------------

valor = 1
while valor <= 5:
    print("Contando:", valor)
    valor += 1



# -------------------------------------------------------------
# BUCLES FOR
# -------------------------------------------------------------

# Los bucles for recorren secuencias como listas, tuplas, cadenas o rangos.
for numero in [1, 2, 3, 4, 5]:
    print("Número:", numero)

# También se puede usar range() para secuencias numéricas
for i in range(5):
    print("Iteración número:", i)

# Puedes indicar el rango de inicio y fin
for i in range(2, 7):
    print("Contando desde 2 hasta 6:", i)

# Con un paso personalizado
for i in range(0, 10, 2):
    print("De dos en dos:", i)

# Recorrer una cadena de texto
for letra in "Python":
    print("Letra:", letra)

# Recorrer listas con índices usando enumerate()
frutas = ["manzana", "banana", "pera"]
for indice, fruta in enumerate(frutas):
    print(f"Fruta #{indice}: {fruta}")

# Recorrer diccionarios
colores = {"rojo": "#FF0000", "verde": "#00FF00", "azul": "#0000FF"}
for nombre, codigo in colores.items():
    print(f"El color {nombre} tiene el código {codigo}")

# Usar break y continue
for n in range(1, 10):
    if n == 5:
        continue  # salta el número 5
    if n == 8:
        break
    print(n)



# -------------------------------------------------------------
# FUNCIONES
# -------------------------------------------------------------

def saludar_usuario():
    """Muestra un saludo simple."""
    print("Hola!")

saludar_usuario()

def saludar_usuario_por_nombre(nombre):
    """Muestra un saludo personalizado."""
    print(f"Hola, {nombre}!")

saludar_usuario_por_nombre("Ana")

# Funciones con valores de retorno
def obtener_nombre_completo(nombre, apellido):
    return f"{nombre} {apellido}"

print(obtener_nombre_completo("Marie", "Curie"))

# -------------------------------------------------------------
# CLASES Y OBJETOS
# -------------------------------------------------------------

class Perro:
    """Un intento simple de modelar un perro."""
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad

    def sentarse(self):
        print(f"{self.nombre} se ha sentado.")

    def ladrar(self):
        print(f"{self.nombre} dice: ¡Guau!")

mi_perro = Perro('Firulais', 5)
print(f"Mi perro se llama {mi_perro.nombre} y tiene {mi_perro.edad} años.")
mi_perro.sentarse()
mi_perro.ladrar()



# -------------------------------------------------------------
# ARGUMENTOS
# -------------------------------------------------------------

# 1️⃣ Argumentos POSICIONALES
# Se pasan en el orden en que se definen en la función.
def mostrar_info(nombre, edad):
    print(f"{nombre} tiene {edad} años.")

mostrar_info("Lucía", 25)


# 2️⃣ Argumentos por PALABRA CLAVE
# Se especifica el nombre del parámetro al llamar a la función.
mostrar_info(edad=30, nombre="Carlos")


# 3️⃣ Argumentos ARBITRARIOS (*args)
# Se usa * para recibir una cantidad variable de argumentos posicionales.
def sumar_todo(*numeros):
    total = sum(numeros)
    print("Suma total:", total)

sumar_todo(1, 2, 3, 4, 5)


# 4️⃣ Argumentos ARBIT. CON NOMBRE (**kwargs)
# Se usa ** para recibir pares clave=valor
def mostrar_config(**opciones):
    for clave, valor in opciones.items():
        print(f"{clave}: {valor}")

mostrar_config(resolucion="1080p", fullscreen=True, volumen=80)



# -------------------------------------------------------------
# PROGRAMACIÓN MODULAR
# -------------------------------------------------------------

# Consiste en dividir el código en varios archivos (módulos) para mantenerlo organizado y reutilizable.
# Crear un archivo llamado "saludos.py" con:
def hola(nombre):
    print(f"¡Hola, {nombre}!")

# Luego, en main.py:
import saludos
saludos.hola("Lucía")

# También puedes importar funciones específicas:
from saludos import hola
hola("Carlos")

# O usar un alias:
import saludos as s
s.hola("María")

# -------------------------------------------------------------
# PAQUETES EXTERNOS Y DISTRIBUCIÓN
# -------------------------------------------------------------

# Un *paquete* en Python es una carpeta que contiene varios módulos y un archivo __init__.py
# Ejemplo de estructura:
# mi_paquete/
# ├── __init__.py
# ├── modulo1.py
# └── modulo2.py

# Para crear un paquete instalable se usa un archivo setup.py:
"""
from setuptools import setup, find_packages

setup(
    name='nombre_mi_paquete',
    version='1.0',
    packages=find_packages(),
    author='nombre_apellido',  # dependencias opcionales
)
"""

# Luego se genera la distribución:
'python setup.py sdist bdist_wheel'

# Esto genera archivos en la carpeta "dist/":
#   mi_paquete-1.0.tar.gz
#   mi_paquete-1.0-py3-none-any.whl

# Para instalar el paquete (en otra ubicacion):
'pip install "C:/directorios/hasta/carpeta/dist/mi_paquete-1.0.tar.gz"'
'pip install "C:/directorios/hasta/carpeta/dist/mi_paquete-1.0-py3-none-any.whl"'

# Crear un test.py que importe los paquetes y ejecute las funciones
from saludos.hola import saludar
saludar()



# -------------------------------------------------------------
# COMPREHENSIONS Y PROGRAMACIÓN FUNCIONAL
# -------------------------------------------------------------

# Permiten crear listas, diccionarios o conjuntos de forma compacta.

# Lista de cuadrados
cuadrados = [x**2 for x in range(10)]
print(cuadrados)

# Filtrar elementos (solo pares)
pares = [x for x in range(10) if x % 2 == 0]
print(pares)

# Diccionario con claves y valores procesados
nombres = ["Ana", "Luis", "María"]
longitudes = {nombre: len(nombre) for nombre in nombres}
print(longitudes)

# Conjuntos con comprehensions
conjunto = {x for x in range(10) if x % 3 == 0}
print(conjunto)



# -------------------------------------------------------------
# FUNCIONES LAMBDA
# -------------------------------------------------------------

# Una función lambda es una función anónima (sin nombre) de una sola línea.
# Ejemplo básico:
doble = lambda x: x * 2
print(doble(5))

# Se usan mucho con funciones como map(), filter() y reduce()

# map(función, iterable) aplica una función a cada elemento
numeros = [1, 2, 3, 4, 5]
dobles = list(map(lambda n: n * 2, numeros))
print(dobles)

# filter(función, iterable) filtra elementos que cumplan una condición
pares = list(filter(lambda n: n % 2 == 0, numeros))
print(pares)

# reduce(función, iterable) combina elementos reduciéndolos a un solo valor
from functools import reduce
suma = reduce(lambda a, b: a + b, numeros)
print("Suma total:", suma)

