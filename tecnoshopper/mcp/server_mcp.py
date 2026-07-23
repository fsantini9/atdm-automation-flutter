import json
import os
import sys
from datetime import datetime

from mcp.server.fastmcp import FastMCP

mcp = FastMCP("TecnoShopper QA MCP")


# Archivos del servidor MCP
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

CASOS_FILE = os.path.join(BASE_DIR, "casos.json")
RESULTADOS_FILE = os.path.join(BASE_DIR, "resultados.json")

# Ruta del proyecto TecnoShopper
PROJECT_ROOT = r"C:\Users\Francisco\Desktop\ProyectosGit\atdm-automation-flutter\tecnoshopper"

ALLURE_RESULTS = os.path.join(PROJECT_ROOT, "allure-results")


def leer_json(archivo):
    """
    Lee un archivo JSON y devuelve su contenido.
    """
    if not os.path.exists(archivo):
        return []

    with open(archivo, "r", encoding="utf-8") as f:
        return json.load(f)


def guardar_json(archivo, datos):
    """
    Guarda información en un archivo JSON.
    """
    with open(archivo, "w", encoding="utf-8") as f:
        json.dump(datos, f, indent=4, ensure_ascii=False)


@mcp.tool()
def obtener_casos():
    """
    Obtiene todos los casos de prueba disponibles.
    """

    casos = leer_json(CASOS_FILE)

    return {
        "cantidad": len(casos),
        "casos": casos,
    }


@mcp.tool()
def crear_caso(nombre: str, pasos: list, resultado_esperado: str):
    """
    Crea un nuevo caso de prueba.
    """

    casos = leer_json(CASOS_FILE)

    nuevo_id = f"TC{len(casos)+1:03d}"

    nuevo_caso = {
        "id": nuevo_id,
        "nombre": nombre,
        "pasos": pasos,
        "resultado_esperado": resultado_esperado,
    }

    casos.append(nuevo_caso)

    guardar_json(CASOS_FILE, casos)

    return {
        "mensaje": "Caso creado correctamente",
        "caso": nuevo_caso,
    }


@mcp.tool()
def guardar_resultado(id_caso: str, resultado: str, observacion: str):
    """
    Guarda el resultado de un caso ejecutado.
    """

    resultados = leer_json(RESULTADOS_FILE)

    nuevo = {
        "caso": id_caso,
        "resultado": resultado,
        "observacion": observacion,
        "fecha": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
    }

    resultados.append(nuevo)

    guardar_json(RESULTADOS_FILE, resultados)

    return {
        "mensaje": "Resultado guardado correctamente",
        "resultado": nuevo,
    }


@mcp.tool()
def obtener_resultados():
    """
    Obtiene todos los resultados almacenados.
    """

    resultados = leer_json(RESULTADOS_FILE)

    aprobados = len(
        [r for r in resultados if r["resultado"].upper() == "PASS"]
    )

    return {
        "total_ejecutados": len(resultados),
        "pass": aprobados,
        "fail": len(resultados) - aprobados,
        "detalle": resultados,
    }


@mcp.tool()
def listar_proyecto():
    """
    Devuelve la estructura completa del proyecto TecnoShopper.
    """

    if not os.path.exists(PROJECT_ROOT):
        return {
            "error": f"No existe la carpeta: {PROJECT_ROOT}"
        }

    archivos = []

    for root, dirs, files in os.walk(PROJECT_ROOT):

        dirs[:] = [
            d for d in dirs
            if d not in (
                ".git",
                ".dart_tool",
                ".idea",
                ".gradle",
                "build",
                ".vscode"
            )
        ]

        for archivo in files:
            ruta = os.path.join(root, archivo)
            archivos.append(os.path.relpath(ruta, PROJECT_ROOT))

    archivos.sort()

    return {
        "proyecto": "TecnoShopper",
        "cantidad_archivos": len(archivos),
        "archivos": archivos,
    }


@mcp.tool()
def leer_archivo_proyecto(ruta: str):
    """
    Lee el contenido de un archivo del proyecto TecnoShopper.

    Ejemplos:
    - lib/main.dart
    - pubspec.yaml
    - patrol_test/login/tests/login_test.dart
    """

    archivo = os.path.join(PROJECT_ROOT, ruta)

    if not os.path.exists(archivo):
        return {
            "error": f"No existe el archivo '{ruta}'"
        }

    if not os.path.isfile(archivo):
        return {
            "error": f"'{ruta}' no es un archivo"
        }

    try:
        with open(archivo, "r", encoding="utf-8") as f:
            contenido = f.read()

        return {
            "ruta": ruta,
            "contenido": contenido,
        }

    except Exception as e:
        return {
            "error": str(e)
        }

@mcp.tool()
def analizar_allure():
    """
    Analiza los resultados de Allure generados por la última ejecución.
    """

    if not os.path.exists(ALLURE_RESULTS):
        return {
            "error": "No existe la carpeta allure-results."
        }

    resultados = []

    total = 0
    passed = 0
    failed = 0
    broken = 0
    skipped = 0

    for archivo in os.listdir(ALLURE_RESULTS):

        if not archivo.endswith("-result.json"):
            continue

        ruta = os.path.join(ALLURE_RESULTS, archivo)

        try:
            with open(ruta, "r", encoding="utf-8") as f:
                test = json.load(f)

            nombre = test.get("name", "Sin nombre")
            estado = test.get("status", "unknown")

            resultados.append({
                "nombre": nombre,
                "estado": estado
            })

            total += 1

            if estado == "passed":
                passed += 1
            elif estado == "failed":
                failed += 1
            elif estado == "broken":
                broken += 1
            elif estado == "skipped":
                skipped += 1

        except Exception as e:

            resultados.append({
                "archivo": archivo,
                "error": str(e)
            })

    porcentaje = 0

    if total > 0:
        porcentaje = round((passed / total) * 100, 2)

    return {
        "tests_ejecutados": total,
        "passed": passed,
        "failed": failed,
        "broken": broken,
        "skipped": skipped,
        "porcentaje_exito": porcentaje,
        "detalle": resultados
    }

if __name__ == "__main__":
    print(f"[MCP] Servidor iniciado: {mcp.name}", file=sys.stderr)
    mcp.run()