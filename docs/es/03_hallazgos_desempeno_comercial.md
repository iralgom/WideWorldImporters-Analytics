# Hallazgos de Desempeño Comercial

## 1. Propósito

Este documento resume los principales hallazgos obtenidos del análisis inicial de desempeño comercial realizado sobre `Fact.Sale`.

El análisis responde principalmente a las siguientes preguntas de negocio:

* **BQ01** — ¿Cómo han evolucionado los ingresos, la utilidad, las unidades vendidas y el volumen de facturas?
* **BQ02** — ¿El crecimiento de los ingresos ha estado acompañado por un crecimiento proporcional de la utilidad?
* **BQ03** — ¿Existen patrones anuales, mensuales o estacionales relevantes?

El objetivo de esta fase es establecer cómo se ha comportado comercialmente Wide World Importers antes de investigar los factores que explican dicho comportamiento por producto, cliente, geografía y vendedor.

---

## 2. Periodo de análisis

Los datos disponibles cubren el periodo comprendido entre:

**1 de enero de 2013 y 31 de mayo de 2016**

El año 2016 es incompleto y contiene únicamente cinco meses de información.

Por esta razón:

> Las comparaciones anuales directas entre 2016 y los años completos anteriores no son analíticamente válidas.

Para 2016 deben utilizarse comparaciones de periodos equivalentes, principalmente análisis mensual interanual o comparaciones enero–mayo.

---

## 3. Línea base comercial

Durante todo el periodo disponible, Wide World Importers registró:

| KPI                           |       Resultado |
| ----------------------------- | --------------: |
| Facturas                      |          70,510 |
| Unidades vendidas             |       8,950,628 |
| Ingresos                      | $172,261,341.20 |
| Utilidad                      |  $85,729,180.90 |
| Margen de utilidad            |          49.77% |
| Ingreso promedio por factura  |       $2,443.08 |
| Utilidad promedio por factura |       $1,215.84 |

Los ingresos se miden antes de impuestos, de acuerdo con las definiciones establecidas en el marco de KPIs.

Estos valores constituyen la línea base contra la cual deberán reconciliarse posteriormente los resultados analíticos y las medidas desarrolladas en Power BI.

---

## 4. Desempeño anual

La actividad comercial mostró crecimiento sostenido durante los tres años completos disponibles.

| Año  | Facturas |  Unidades | Ingresos | Utilidad | Margen |
| ---- | -------: | --------: | -------: | -------: | -----: |
| 2013 |   18,767 | 2,401,657 | $45.71 M | $22.77 M | 49.81% |
| 2014 |   20,303 | 2,567,401 | $49.93 M | $24.83 M | 49.73% |
| 2015 |   22,250 | 2,740,266 | $53.99 M | $26.96 M | 49.93% |

### Crecimiento anual

**2014 vs. 2013**

* Ingresos: **+9.24%**
* Utilidad: **+9.05%**
* Facturas: **+8.18%**
* Unidades: **+6.90%**

**2015 vs. 2014**

* Ingresos: **+8.14%**
* Utilidad: **+8.58%**
* Facturas: **+9.59%**
* Unidades: **+6.73%**

### Hallazgo

El crecimiento entre 2013 y 2015 fue amplio y no dependió únicamente de una variable.

Los ingresos crecieron acompañados por incrementos en:

* número de facturas;
* unidades vendidas;
* utilidad total.

La utilidad creció aproximadamente al mismo ritmo que los ingresos.

Esto indica que la expansión comercial no implicó, a nivel agregado, un deterioro relevante de la rentabilidad.

---

## 5. Estabilidad del margen de utilidad

Aunque existe variación mensual, el margen anual permanece notablemente estable:

* 2013: **49.81%**
* 2014: **49.73%**
* 2015: **49.93%**

A nivel mensual, el margen observado oscila aproximadamente entre:

**48.79% y 50.62%**.

### Hallazgo

La evidencia disponible no permite afirmar que la rentabilidad agregada sea altamente volátil.

Una interpretación más precisa es:

> El negocio mantiene un margen agregado estructuralmente estable alrededor del 50%, aunque existen fluctuaciones mensuales.

Esta estabilidad puede ocultar diferencias importantes entre productos, clientes, territorios o transacciones individuales.

---

## 6. Variabilidad mensual

El comportamiento mensual presenta una volatilidad considerablemente mayor que los agregados anuales.

Por ejemplo, durante 2015:

**Abril vs. marzo**

* Ingresos: **+12.04%**
* Utilidad: **+12.70%**
* Facturas: **+10.93%**
* Unidades: **+7.01%**

**Mayo vs. abril**

* Ingresos: **-11.68%**
* Utilidad: **-12.24%**
* Facturas: **-8.07%**
* Unidades: **-11.73%**

**Julio vs. junio**

* Ingresos: **+14.17%**
* Utilidad: **+16.01%**
* Facturas: **+15.34%**
* Unidades: **+19.18%**

**Agosto vs. julio**

* Ingresos: **-23.61%**
* Utilidad: **-23.98%**
* Facturas: **-24.19%**
* Unidades: **-23.33%**.

### Hallazgo

El desempeño de corto plazo es significativamente más variable que lo que sugieren los resultados anuales.

Los ingresos, la utilidad, el número de facturas y las unidades suelen moverse en la misma dirección, lo que indica que el volumen comercial es un factor importante en las fluctuaciones mensuales.

Sin embargo, las magnitudes no siempre cambian de manera proporcional, por lo que también pueden existir efectos de precio o mezcla de productos.

---

## 7. Crecimiento interanual mensual

El análisis YoY muestra que el crecimiento anual no se distribuye uniformemente entre los meses.

Algunos ejemplos de 2015 frente a 2014:

* Abril: ingresos **+23.88%**
* Abril: utilidad **+24.83%**
* Mayo: ingresos **-2.39%**
* Mayo: utilidad **-2.35%**
* Septiembre: ingresos **+20.08%**
* Septiembre: utilidad **+18.75%**.

Durante los primeros cinco meses de 2016 también existe un comportamiento mixto:

* Enero: +1.05%
* Febrero: -4.52%
* Marzo: +2.59%
* Abril: -10.04%
* Mayo: +10.94% en ingresos YoY.

### Hallazgo

El crecimiento comercial no sigue una trayectoria continua.

Existen meses de fuerte expansión seguidos por periodos de contracción.

Esto indica que los agregados anuales esconden dinámicas internas relevantes que deben explicarse mediante análisis de producto, cliente y composición de ventas.

---

## 8. Estacionalidad observada

El promedio de ingresos por mes calendario muestra diferencias relevantes.

El mayor ingreso mensual promedio se registra en:

**Julio — aproximadamente $4.77 M**

El menor corresponde a:

**Febrero — aproximadamente $3.61 M**

Otros meses relativamente fuertes son:

* Mayo — ~$4.62 M
* Abril — ~$4.45 M
* Junio — ~$4.28 M.

### Hallazgo

Los resultados sugieren un patrón recurrente:

* febrero tiende a presentar menor actividad;
* la actividad aumenta durante primavera y principios del verano;
* julio es el mes más fuerte;
* agosto presenta una caída marcada respecto de julio.

Sin embargo, únicamente se dispone de tres años calendario completos.

Por tanto:

> El patrón debe considerarse **estacionalidad observada**, no una estructura estacional plenamente demostrada.

---

## 9. Eficiencia comercial

Se analizaron cuatro indicadores adicionales:

* margen de utilidad;
* ingreso por factura;
* unidades por factura;
* ingreso por unidad.

### Ingreso por factura

El ingreso promedio por factura permanece relativamente estable alrededor de la línea base de $2.44 mil.

Algunos valores observados:

* Enero 2013: $2,300.43
* Agosto 2014: $2,598.91
* Mayo 2016: $2,551.81.

### Unidades por factura

El número promedio de unidades por factura presenta mayor variación.

Ejemplos:

* Enero 2013: 117.92
* Mayo 2013: 133.60
* Septiembre 2015: 117.69
* Mayo 2016: 138.62.

### Ingreso por unidad

El ingreso promedio generado por unidad también cambia entre periodos.

Ejemplos:

* Agosto 2013: ~$18.19
* Agosto 2014: ~$21.00
* Febrero 2015: ~$20.66
* Enero 2016: ~$17.77.

### Interpretación

El comportamiento conjunto de unidades vendidas e ingreso por unidad indica que el crecimiento comercial no puede atribuirse exclusivamente al volumen.

Un incremento del ingreso por unidad puede provenir de:

1. mayores precios;
2. mayor participación de productos de precio elevado;
3. una combinación de ambos efectos.

Por tanto:

> El ingreso por unidad debe interpretarse como un indicador diagnóstico, no como un precio promedio puro.

---

## 10. Evaluación del crecimiento 2014–2015

Entre 2014 y 2015:

* ingresos: **+8.14%**
* utilidad: **+8.58%**
* facturas: **+9.59%**
* unidades: **+6.73%**.

### Hecho observado

Los ingresos crecieron más que las unidades vendidas.

### Inferencia

El volumen por sí solo no explica completamente el crecimiento de los ingresos.

### Lo que todavía no puede afirmarse

Los datos actuales no permiten concluir que el incremento de precios sea la principal causa.

Un cambio en la mezcla de productos podría generar el mismo comportamiento.

### Análisis requerido

Será necesario descomponer el cambio de ingresos entre:

* efecto volumen;
* efecto precio;
* efecto mezcla de productos.

---

## 11. Respuestas preliminares a las preguntas de negocio

### BQ01 — ¿Cómo evolucionó el desempeño comercial?

El negocio mostró crecimiento consistente entre 2013 y 2015.

Ingresos, utilidad, facturas y unidades aumentaron.

Sin embargo, el comportamiento mensual presenta una volatilidad considerablemente mayor.

### BQ02 — ¿El crecimiento de ingresos estuvo acompañado por crecimiento de utilidad?

Sí, a nivel agregado.

Los ingresos y la utilidad crecieron a ritmos similares y el margen permaneció aproximadamente estable alrededor del 50%.

### BQ03 — ¿Existen patrones temporales relevantes?

Sí.

Se observan:

* fluctuaciones mensuales significativas;
* diferencias relevantes en crecimiento YoY;
* fortaleza recurrente alrededor de julio;
* debilidad recurrente en febrero y agosto.

La limitada profundidad histórica obliga a considerar estos patrones como indicios y no como reglas definitivas.

---

## 12. Nuevas preguntas generadas por el análisis

El análisis inicial genera nuevas preguntas que deben investigarse:

1. ¿Qué explica la diferencia entre el crecimiento de ingresos y el crecimiento de unidades?
2. ¿Cuánto del crecimiento proviene de volumen, precio o mezcla de productos?
3. ¿Qué productos explican los picos y caídas mensuales?
4. ¿Los productos de mayor ingreso son también los de mayor utilidad?
5. ¿Existen productos que expliquen las fluctuaciones del margen agregado?
6. ¿Por qué las ventas con utilidad negativa se concentran en únicamente 18 productos?
7. ¿La composición de clientes o territorios explica parte de la volatilidad mensual?
8. ¿Los cambios en ingreso por factura provienen de unidades, precio o mezcla?

---

## 13. Conclusión

El análisis comercial inicial muestra un negocio caracterizado por:

* crecimiento sostenido entre 2013 y 2015;
* rentabilidad agregada estable;
* variabilidad mensual significativa;
* patrones estacionales observables;
* crecimiento comercial explicado por más factores que únicamente el volumen.

La evidencia permite cerrar la fase descriptiva del desempeño comercial.

Sin embargo, todavía no permite identificar con precisión los factores causales del crecimiento de ingresos.

El siguiente paso debe centrarse en separar:

> **efecto volumen, efecto precio y efecto mezcla de productos.**

---

## 14. Siguiente paso

El siguiente script analítico será:

`sql/02_analysis/02_price_volume_analysis.sql`

Su objetivo será determinar si los cambios en desempeño comercial se relacionan principalmente con:

* cambios en las unidades vendidas;
* cambios en el precio efectivo;
* cambios en la composición de productos.

Este análisis permitirá poner a prueba la principal hipótesis generada durante la fase de desempeño comercial antes de avanzar hacia el análisis detallado de productos.
