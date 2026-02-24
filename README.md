# cg_example_yml

## Descripción del Proyecto

Este proyecto es un ejemplo de un entorno de verificación en SystemVerilog utilizando UVM (Universal Verification Methodology). Incluye componentes de testbench, secuencias virtuales, utilidades y VIPs (Verification IP) para interfaces A y B.

## Estructura del Directorio

### environments/
Contiene los paquetes y archivos principales del entorno de verificación:
- `project_coverage_pkg.sv`: Paquete para cobertura.
- `project_defn_pkg.sv`: Definiciones del proyecto.
- `project_env_pkg.sv`: Paquete del entorno.
- `project_tb_top.sv`: Top-level del testbench.

### sim/
Scripts para simulación y regresiones:
- `regressions/`: Archivos de regresión como `default.rmdb`, `nightly_test.txt`, `sanity_test.txt`, `setup.do`.
- `run/`: Scripts de ejecución: `compile.do`, `prepare.do`, `run.do`, `sim.do`, `wave.do`.

### testcases/
Casos de prueba y secuencias:
- `test/`: Clases de prueba: `project_test_pkg.sv`, `reset_test.sv`, `sanity_test.sv`, `top_test_base.sv`.
- `vseq/`: Secuencias virtuales: `project_vseq_pkg.sv`, `reset_vseq.sv`, `sanity_vseq.sv`, `top_base_vseq.sv`.

### utils/
Utilidades para la verificación:
- `distribution.sv`: Clase de distribución.
- `in_order_comparator.sv`: Comparador en orden.
- `utils_pkg.sv`: Paquete de utilidades.

### vip/
Verification IP para interfaces:
- `a_vip/`: VIP para interfaz A, incluyendo agente, driver, monitor, secuencias, etc.
- `b_vip/`: VIP para interfaz B, similar a A.

Cada directorio VIP incluye archivos como `*_agent.svh`, `*_driver.svh`, `*_monitor.svh`, `*_seq_item.svh`, `*_seq.svh`, `*_sequencer.svh`, y un `compile.do`.

## Configuración y Ejecución

Para compilar y ejecutar las simulaciones, utiliza los scripts en `sim/run/`:
- `compile.do`: Compila el proyecto.
- `prepare.do`: Prepara el entorno.
- `run.do`: Ejecuta la simulación.
- `sim.do`: Script de simulación principal.
- `wave.do`: Configura las ondas para visualización.

Asegúrate de tener un simulador SystemVerilog compatible con UVM instalado (como ModelSim, QuestaSim, etc.).

## Regresiones

Los archivos de regresión se encuentran en `sim/regressions/`:
- `sanity_test.txt`: Pruebas básicas.
- `nightly_test.txt`: Pruebas nocturnas.
- `default.rmdb`: Base de datos de resultados.

## Contribución

Si deseas contribuir, por favor revisa los archivos y sigue las mejores prácticas de UVM.
