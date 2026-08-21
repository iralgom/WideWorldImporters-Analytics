# Hallazgos del Análisis Price–Volume–Mix

## 1. Resumen Ejecutivo

WideWorldImporters presentó un crecimiento sostenido de los ingresos durante los
tres años calendario completos disponibles en el conjunto de datos.

Los ingresos aumentaron de **$45.71 millones en 2013 a $53.99 millones en
2015**, mientras que las unidades vendidas pasaron de **2.40 millones a
2.74 millones**.

El análisis investigó inicialmente si el crecimiento de los ingresos había sido
impulsado por un mayor volumen de ventas o por incrementos en el ingreso efectivo
por unidad. Aunque el ingreso agregado por unidad aumentó de **$19.03 en 2013 a
$19.70 en 2015**, la validación a nivel producto mostró que ninguno de los 219
productos comparables presentó cambios en su ingreso efectivo por unidad entre
años completos consecutivos.

Por lo tanto, el incremento del ingreso agregado por unidad refleja un cambio en
la composición de las unidades vendidas y no un crecimiento observado del
ingreso por unidad dentro de cada producto.

La descomposición volumen–mix muestra que:

- **74.71%** del crecimiento de los ingresos de 2014 fue atribuible al volumen y
  **25.29%** al mix de productos.
- **82.76%** del crecimiento de los ingresos de 2015 fue atribuible al volumen y
  **17.24%** al mix de productos.

El crecimiento de los ingresos estuvo, por tanto, impulsado principalmente por
el **volumen**, complementado por una contribución positiva del mix de
productos. La contribución relativa del mix disminuyó en 2015, incrementando la
dependencia del crecimiento respecto de la expansión de unidades vendidas.

---

## 2. Pregunta de Negocio

El análisis responde la siguiente pregunta principal:

> ¿Qué impulsó el crecimiento de los ingresos de WideWorldImporters durante el
> periodo completo 2013–2015: un mayor volumen de unidades, cambios en el valor
> efectivo de los productos o cambios en la composición de los productos
> vendidos?

Como preguntas complementarias se plantearon:

- ¿Los ingresos crecieron a una tasa superior a las unidades vendidas?
- ¿Cambió el ingreso efectivo por unidad a nivel de producto individual?
- ¿Cambió la composición de las unidades vendidas hacia productos de mayor
  valor relativo?
- ¿Qué proporción del crecimiento puede atribuirse al volumen y qué proporción
  al mix de productos?
- ¿Qué productos fueron los principales impulsores y detractores del efecto
  mix?

---

## 3. Alcance Analítico y Metodología

### Fuentes de datos

El análisis utiliza los siguientes objetos de `WideWorldImportersDW`:

- `Fact.Sale`
- `Dimension.Date`
- `Dimension.[Stock Item]`

Se utiliza `WWI Stock Item ID` como identificador de negocio del producto para
evitar que las distintas versiones históricas de la dimensión sean
interpretadas como productos diferentes.

### Periodo analizado

El análisis interanual principal se restringe a:

- 2013
- 2014
- 2015

Estos corresponden a los años calendario completos disponibles en el conjunto
de datos.

El Data Warehouse también contiene información de ventas de 2016, pero
únicamente hasta el **31 de mayo de 2016**. En consecuencia, 2016 no se utiliza
para obtener conclusiones basadas en comparaciones de años completos.

### Ingreso efectivo por unidad

Para este análisis:

**Ingreso por Unidad = Total Excluding Tax / Quantity**

Esta métrica representa el ingreso efectivo generado por unidad registrado en
`Fact.Sale`.

No debe interpretarse automáticamente como precio de catálogo, precio de lista
o como resultado de una acción formal de pricing.

---

## 4. Desempeño Comercial Anual

El desempeño anual aumentó consistentemente durante los tres años completos.

| Año | Unidades Vendidas | Ingresos | Ingreso por Unidad |
|---|---:|---:|---:|
| 2013 | 2,401,657 | $45,707,188.00 | $19.03 |
| 2014 | 2,567,401 | $49,929,487.20 | $19.45 |
| 2015 | 2,740,266 | $53,991,490.45 | $19.70 |

Entre 2013 y 2015:

- las unidades vendidas aumentaron en **338,609 unidades**;
- los ingresos aumentaron en **$8,284,302.45**;
- el ingreso agregado por unidad aumentó de **$19.03 a $19.70**.

El crecimiento simultáneo del volumen y del ingreso agregado por unidad hizo
necesario descomponer los resultados para determinar las fuentes subyacentes
del crecimiento.

---

## 5. Crecimiento Interanual

### 2014 vs. 2013

| Métrica | Variación YoY |
|---|---:|
| Unidades Vendidas | +6.90% |
| Ingresos | +9.24% |
| Ingreso por Unidad | +2.19% |

Los ingresos crecieron a una tasa superior al volumen de unidades.

### 2015 vs. 2014

| Métrica | Variación YoY |
|---|---:|
| Unidades Vendidas | +6.73% |
| Ingresos | +8.14% |
| Ingreso por Unidad | +1.31% |

Los ingresos volvieron a crecer a una tasa superior al volumen.

A nivel agregado, estos resultados podrían interpretarse inicialmente como
evidencia de un incremento en el valor efectivo de los productos. Por ello fue
necesario realizar una validación a nivel producto antes de atribuir esta
diferencia a un efecto precio o valor.

---

## 6. Validación a Nivel Producto

### Cobertura de productos

El mismo número de productos de negocio distintos registró ventas en cada uno
de los años calendario completos.

| Año | Productos Vendidos |
|---|---:|
| 2013 | 219 |
| 2014 | 219 |
| 2015 | 219 |

Esto proporciona un universo estable de productos para la comparación
interanual.

### Estabilidad del ingreso por unidad

El ingreso efectivo por unidad de cada producto fue comparado contra el año
anterior.

| Año | Productos Comparados | Aumentaron | Disminuyeron | Sin Cambio |
|---|---:|---:|---:|---:|
| 2014 | 219 | 0 | 0 | 219 |
| 2015 | 219 | 0 | 0 | 219 |

El resultado es inequívoco dentro de los datos observados:

**los 219 productos comparables mantuvieron sin cambios su ingreso efectivo por
unidad entre años completos consecutivos.**

Por tanto, el incremento observado en el ingreso agregado por unidad no puede
atribuirse a aumentos observados del ingreso por unidad dentro de cada producto.

La evidencia indica, en cambio, un **efecto de mix de productos**: cambió el
peso relativo de los productos dentro del total de unidades vendidas.

---

## 7. Descomposición Volumen–Mix

El crecimiento de los ingresos se descompuso en dos componentes.

### Efecto Volumen — Volume Effect

Representa el cambio en los ingresos atribuible a la variación en el número
total de unidades vendidas, evaluado utilizando el ingreso agregado por unidad
del año anterior.

### Efecto Mix — Mix Effect

Representa el cambio restante en los ingresos asociado con la modificación del
ingreso agregado por unidad.

Dado que el ingreso por unidad a nivel producto permaneció sin cambios para los
219 productos comparables, este efecto residual es atribuible a cambios en la
composición de las unidades vendidas dentro del universo de productos
observado.

### Resultados

| Comparación | Cambio en Ingresos | Efecto Volumen | Contribución Volumen | Efecto Mix | Contribución Mix |
|---|---:|---:|---:|---:|---:|
| 2014 vs. 2013 | $4,222,299.20 | $3,154,360.42 | 74.71% | $1,067,938.78 | 25.29% |
| 2015 vs. 2014 | $4,062,003.25 | $3,361,788.98 | 82.76% | $700,214.27 | 17.24% |

La descomposición asigna completamente el cambio observado en los ingresos.

**2014**

`$3,154,360.42 + $1,067,938.78 = $4,222,299.20`

**2015**

`$3,361,788.98 + $700,214.27 = $4,062,003.25`

El volumen fue la principal fuente de crecimiento en ambos periodos.

Su contribución aumentó de **74.71% a 82.76%**, mientras que la contribución del
mix favorable disminuyó de **25.29% a 17.24%**.

---

## 8. Cómo el Mix de Productos Generó Crecimiento

La contribución de un producto al efecto mix depende de dos factores:

1. cómo cambió su participación dentro del total de unidades vendidas; y
2. si su ingreso por unidad se encontraba por encima o por debajo del promedio
   del portafolio.

Un efecto mix favorable puede producirse mediante:

- un aumento en la participación de productos de valor relativamente alto; o
- una disminución en la participación de productos de valor relativamente bajo.

Un efecto mix desfavorable puede producirse mediante:

- una disminución en la participación de productos de valor relativamente alto;
  o
- un aumento en la participación de productos de valor relativamente bajo.

Esta distinción es importante porque una variación elevada en la participación
de unidades no implica necesariamente un impacto económico elevado.

---

## 9. Principales Impulsores del Mix

### 2014 vs. 2013

Los cinco productos con mayor contribución positiva al efecto mix fueron:

| Producto | Ingreso por Unidad | Cambio de Participación | Efecto Mix |
|---|---:|---:|---:|
| 10 mm Double sided bubble wrap 50m | $105.00 | +0.1051 pp | +$232,057.68 |
| 32 mm Double sided bubble wrap 50m | $112.00 | +0.0858 pp | +$204,758.13 |
| Shipping carton (Brown) 500x310x310mm | $2.55 | -0.4284 pp | +$181,275.12 |
| Shipping carton (Brown) 305x305x305mm | $3.50 | -0.3824 pp | +$152,493.80 |
| Black and orange glass with care despatch tape 48mmx75m | $3.70 | -0.3506 pp | +$137,999.68 |

Los resultados muestran los dos mecanismos mediante los cuales puede producirse
un movimiento favorable del mix.

Productos de bubble wrap con un ingreso por unidad relativamente elevado
ganaron participación, mientras que varios productos de packaging de bajo valor
relativo redujeron su peso dentro de las unidades vendidas.

### 2015 vs. 2014

Los cinco productos con mayor contribución positiva fueron:

| Producto | Ingreso por Unidad | Cambio de Participación | Efecto Mix |
|---|---:|---:|---:|
| Shipping carton (Brown) 305x305x305mm | $3.50 | -0.5102 pp | +$222,970.93 |
| 20 mm Double sided bubble wrap 50m | $108.00 | +0.0860 pp | +$208,636.35 |
| 20 mm Anti static bubble wrap (Blue) 50m | $102.00 | +0.0905 pp | +$204,834.43 |
| Shipping carton (Brown) 229x229x229mm | $1.05 | -0.2254 pp | +$113,654.16 |
| Black and orange fragile despatch tape 48mmx100m | $4.10 | -0.2518 pp | +$105,879.78 |

El principal impulsor de 2015 no fue un producto de alto valor que ganara
participación.

`Shipping carton (Brown) 305x305x305mm`, con un ingreso por unidad de $3.50,
redujo su participación de **1.3632% a 0.8530%**, equivalente a **-0.5102
puntos porcentuales**.

Al encontrarse su ingreso por unidad sustancialmente por debajo del promedio del
portafolio, la reducción de su peso mejoró el mix agregado y produjo una
contribución calculada de **+$222,970.93**.

---

## 10. Principales Detractores del Mix

### 2014 vs. 2013

Los cinco productos con mayor contribución negativa fueron:

| Producto | Ingreso por Unidad | Cambio de Participación | Efecto Mix |
|---|---:|---:|---:|
| Air cushion machine (Blue) | $1,899.00 | -0.0031 pp | -$148,792.80 |
| 32 mm Anti static bubble wrap (Blue) 20m | $48.00 | -0.1363 pp | -$101,374.09 |
| Shipping carton (Brown) 356x229x229mm | $1.14 | +0.1829 pp | -$83,999.25 |
| Black and orange fragile despatch tape 48mmx100m | $4.10 | +0.1618 pp | -$62,039.67 |
| Black and yellow heavy despatch tape 48mmx100m | $4.10 | +0.1560 pp | -$59,809.56 |

### 2015 vs. 2014

Los cinco productos con mayor contribución negativa fueron:

| Producto | Ingreso por Unidad | Cambio de Participación | Efecto Mix |
|---|---:|---:|---:|
| Shipping carton (Brown) 279x254x217mm | $1.11 | +0.2385 pp | -$119,834.49 |
| Air cushion machine (Blue) | $1,899.00 | -0.0020 pp | -$104,731.70 |
| Black and yellow heavy despatch tape 48mmx100m | $4.10 | +0.2290 pp | -$96,317.24 |
| 3 kg Courier post bag (White) 300x190x95mm | $0.66 | +0.1724 pp | -$88,752.84 |
| 32 mm Double sided bubble wrap 50m | $112.00 | -0.0342 pp | -$86,760.15 |

`Air cushion machine (Blue)` demuestra por qué la variación de participación no
debe evaluarse de manera independiente del valor económico del producto.

En 2015, su participación disminuyó únicamente **0.0020 puntos porcentuales**,
de **0.0658% a 0.0638%**.

Sin embargo, su ingreso por unidad fue de **$1,899.00**, generando una
contribución negativa calculada al efecto mix de **-$104,731.70**.

Por tanto, una pequeña variación de participación puede producir un impacto
económico material cuando el valor unitario del producto difiere
sustancialmente del promedio del portafolio.

---

## 11. Reconciliación a Nivel Producto

Como control de validación, las contribuciones individuales al efecto mix fueron
sumadas y comparadas contra el efecto mix agregado.

| Año | Efecto Mix Agregado | Efecto Mix Reconciliado | Diferencia |
|---|---:|---:|---:|
| 2014 | $1,067,938.78 | $1,067,938.62 | $0.16 |
| 2015 | $700,214.27 | $700,214.11 | $0.16 |

Las diferencias de **$0.16** son inmateriales respecto del efecto mix calculado
y son consistentes con la precisión numérica de los cálculos intermedios.

La reconciliación establece trazabilidad analítica entre:

**crecimiento total de ingresos → descomposición volumen/mix → contribuciones
individuales por producto.**

---

## 12. Hallazgos Principales

### 12.1 El crecimiento de los ingresos estuvo dominado por el volumen

Los ingresos aumentaron **$4.22 millones en 2014** y **$4.06 millones en
2015**.

El volumen explicó:

- **74.71%** del incremento de 2014;
- **82.76%** del incremento de 2015.

Por tanto, la evidencia no permite caracterizar el crecimiento como impulsado
principalmente por aumentos del ingreso efectivo por unidad.

### 12.2 El crecimiento del ingreso agregado por unidad fue un efecto de composición

El ingreso agregado por unidad aumentó:

- de **$19.03 en 2013**
- a **$19.45 en 2014**
- y a **$19.70 en 2015**.

Sin embargo, los 219 productos comparables mantuvieron sin cambios su ingreso
individual por unidad.

El aumento agregado fue generado por cambios en la composición relativa de las
unidades vendidas.

### 12.3 El mix contribuyó positivamente en ambos periodos

El mix de productos aportó:

- **$1,067,938.78** al crecimiento de los ingresos de 2014;
- **$700,214.27** al crecimiento de los ingresos de 2015.

El efecto mix fue favorable en ambas comparaciones.

### 12.4 La contribución del mix favorable se debilitó en 2015

El mix representó **25.29%** del crecimiento de 2014 y **17.24%** del
crecimiento de 2015.

Simultáneamente, la contribución del volumen aumentó hasta **82.76%**.

El perfil de crecimiento de 2015 fue, por tanto, más dependiente de la expansión
del número de unidades.

### 12.5 El impacto del mix no puede evaluarse únicamente por cambios de participación

El análisis identificó productos con variaciones muy pequeñas en participación
pero con efectos económicos materiales, así como productos de bajo valor cuya
pérdida de participación contribuyó favorablemente al mix.

Por tanto, el valor económico del producto y la dirección del cambio en su
participación deben analizarse conjuntamente.

### 12.6 El papel de los productos cambió entre periodos

Algunos productos pasaron de ser impulsores a detractores entre 2014 y 2015.

Por ejemplo:

- `10 mm Double sided bubble wrap 50m` generó un efecto de **+$232,057.68** en
  2014 y **-$85,941.51** en 2015.
- `32 mm Double sided bubble wrap 50m` generó un efecto de **+$204,758.13** en
  2014 y **-$86,760.15** en 2015.
- `Shipping carton (Brown) 279x254x217mm` generó un efecto de **+$72,522.26**
  en 2014 y **-$119,834.49** en 2015.

El efecto mix favorable agregado no fue, por tanto, resultado de un conjunto
fijo de productos permanentemente favorables. Las contribuciones individuales
cambiaron de forma material entre periodos.

---

## 13. Interpretación de Negocio

La evidencia respalda la siguiente interpretación:

> El crecimiento de los ingresos de WideWorldImporters durante los años
> completos 2013–2015 estuvo impulsado principalmente por el incremento del
> volumen de unidades y complementado por cambios favorables en el mix de
> productos. Aunque la contribución del mix permaneció positiva, perdió peso
> relativo en 2015, haciendo que el crecimiento dependiera en mayor medida de
> la expansión del volumen.

Esta distinción tiene implicaciones comerciales.

Un crecimiento basado principalmente en volumen requiere que el negocio
continúe generando unidades adicionales. Dependiendo de su causa, esto podría
provenir de más clientes, más transacciones, pedidos de mayor tamaño, mayor
frecuencia de compra u otros mecanismos de expansión de demanda.

**El análisis actual no determina cuál de estos mecanismos produjo el
crecimiento observado.**

De manera similar, el análisis identifica qué productos contribuyeron a los
cambios del mix, pero no determina por qué cambió su demanda relativa.

Responder esas preguntas requiere evidencia adicional.

---

## 14. Limitaciones Analíticas

### 2016 es un periodo parcial

Los datos disponibles para 2016 contienen:

- **1,241,304 unidades vendidas**;
- **$22,633,175.55 de ingresos**;
- **227 productos vendidos**.

Sin embargo, las observaciones terminan el **31 de mayo de 2016**.

Por tanto, los valores interanuales aparentes de **-54.70% en unidades** y
**-58.08% en ingresos** no se interpretan como una contracción anual del
negocio, ya que comparan un periodo parcial con un año completo.

### El ingreso por unidad es una métrica analítica

`Revenue per Unit` se calcula a partir del ingreso transaccional y la cantidad.

El análisis no demuestra que esta métrica sea equivalente al precio de lista,
precio de catálogo o política formal de pricing.

En consecuencia, el hallazgo se expresa como estabilidad del **ingreso efectivo
por unidad**, no como evidencia de que no existieron cambios de precios en
ninguna parte del negocio.

### La descomposición es descriptiva, no causal

El modelo volumen–mix explica cómo puede distribuirse matemáticamente el
crecimiento observado de los ingresos.

No establece las causas de negocio del:

- crecimiento de unidades;
- cambio en las participaciones de productos;
- comportamiento de compra de los clientes;
- disponibilidad de productos;
- promociones;
- diferencias geográficas;
- actividad de la fuerza de ventas; o
- estacionalidad.

Estas explicaciones requieren análisis adicionales.

---

## 15. Siguientes Preguntas Analíticas Recomendadas

El análisis actual responde suficientemente la pregunta sobre los principales
componentes del crecimiento de ingresos y puede considerarse cerrado como
módulo analítico.

Las preguntas de seguimiento con mayor valor son:

1. **¿Qué impulsó el crecimiento del volumen?**  
   Determinar si provino de más clientes, más facturas, más unidades por
   factura o cambios en la frecuencia de compra.

2. **¿El crecimiento de ingresos se tradujo en un crecimiento proporcional de
   la utilidad?**  
   Evaluar si el incremento de volumen y el mix favorable también mejoraron la
   rentabilidad.

3. **¿Qué productos explican las transacciones con utilidad negativa?**  
   Los análisis previos de calidad y desempeño comercial identificaron
   observaciones con utilidad negativa que requieren una investigación
   específica.

4. **¿Los cambios favorables del mix están asociados con clientes o segmentos
   específicos?**  
   Determinar si el efecto está distribuido ampliamente o concentrado en
   determinados clientes.

5. **¿Los cambios en el mix son persistentes o estacionales?**  
   Extender el análisis a comparaciones mensuales o estacionales apropiadas.

Estas preguntas deben abordarse mediante módulos analíticos independientes, en
lugar de ampliar indefinidamente el script actual sin una pregunta de negocio
específica.

---

## 16. Reproducibilidad

Los cálculos que sustentan este documento se encuentran implementados en:

`sql/02_analysis/02_price_volume_mix_analysis.sql`

El script contiene:

- análisis anual de ingresos, unidades e ingreso efectivo por unidad;
- cálculos de crecimiento interanual;
- validación del ingreso por unidad a nivel producto;
- controles de cobertura de productos;
- descomposición volumen–mix;
- análisis de participación de unidades por producto;
- atribución del efecto mix a nivel producto;
- controles de reconciliación; y
- clasificación de principales impulsores y detractores.

Todos los hallazgos cuantitativos presentados en este documento se basan en los
resultados validados de dicho análisis.