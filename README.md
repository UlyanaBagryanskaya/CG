# Проект по НИСу "Грамматика конструкций"
Багрянская Ульяна, БКЛ143

### Материалы
[Данные](/kuda_kak_01.csv)  
[Ссылка на код, здесь целиком с комментарием](/kuda_kak_R.R) ( или ниже по тексту отдельными блоками )

## Рабочая гипотеза

В русском языке конструкция "куда как + Х" на месте Х чаще встречается прилагательное или наречие в сравнительной степени, кажется, что ситуаций, когда на месте Х стоит просто наречие гораздо меньше. В рамках представленного проекта были исследованы конструкции "когда как + Comp" и "когда как + Adv" а также условия, при которых может происходить выбор в пользу той или иной конструкции.

В качестве параметров, которые потенциально определяют выбор конструкции, были подобраны следующие условия:
1. Наличие/ отсутствие подлежащего
2. Одушевленность подлежащего (при его наличии)
3. Наличие сказуемого
4. Наличие прямого зависимого от самой конструкции
5. Семантический класс Х-а

## Данные

### Материал исследования
Материал для каждой конструкции был скачан из Национального корпуса русского языка в общем количестве 200 примеров всего. Разметка осуществлялась вручную. 

### Факторы выбора конструкции
Зависимая переменная: +comp vs -comp (колонка comp). Предположительно зависит:
1. Наличие/ отсутствие подлежащего
2. Одушевленность подлежащего (при его наличии)
3. Наличие сказуемого
4. Наличие прямого зависимого от самой конструкции
5. Семантический класс Х-а

## Логистическая регрессия
<pre><code>
df1 <- data
fit <- glm(Comp ~ Sub + SubAnimacy + DO + sem_humq + sem_abstract + sem_freq +
                  sem_physq + sem_size + sem_quant + sem_dist + sem_speed,
           data = df1, family = binomial()) 
summary(fit)
</code></pre>

Вывод по модели:
<pre><code>
Call:
glm(formula = Comp ~ Sub + SubAnimacy + DO + sem_humq + sem_abstract + 
    sem_freq + sem_physq + sem_size + sem_quant + sem_dist + 
    sem_speed, family = binomial(), data = df1)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.0810  -1.2754   0.6920   0.8393   1.9210  

Coefficients:
              Estimate Std. Error z value Pr(>|z|)  
(Intercept)   0.050177   0.934236   0.054   0.9572  
Sub           0.634785   0.376142   1.688   0.0915 .
SubAnimacy   -0.321079   0.525425  -0.611   0.5411  
DO            0.730226   0.460297   1.586   0.1126  
sem_humq      0.943561   0.972559   0.970   0.3320  
sem_abstract  0.177219   0.917358   0.193   0.8468  
sem_freq      0.008185   1.528463   0.005   0.9957  
sem_physq     0.190539   1.049869   0.181   0.8560  
sem_size      1.358574   1.168188   1.163   0.2448  
sem_quant    -1.723312   1.233373  -1.397   0.1623  
sem_dist     -0.418071   1.132896  -0.369   0.7121  
sem_speed    -0.213937   1.535147  -0.139   0.8892  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 252.23  on 199  degrees of freedom
Residual deviance: 231.66  on 188  degrees of freedom
AIC: 255.66

Number of Fisher Scoring iterations: 4
</code></pre>

Получается, что единственный значимый параметр - это наличие субъекта.

## Корреляция
![Корреляция](/correlation.png)

## T-test
Самый весомый признак, как показала логистическая регрессия - наличие субъекта. Это подтвеждается и t-тестом.
Sub: 109 вхождений признака
t = -2.2569, df = 124.8, p-value = 0.02575
![Sub](/Sub.png)

Более редкие признаки, которые можно взять в расчет:

Sem_humq: 39 вхождений признака
t = -1.9433, df = 157.36, p-value = 0.05377
![sem_himq](/sem_humq.png)

Sem_size: 19 вхождений признака
t = -2.6521, df = 196.65, p-value = 0.008653
![sem_size](/sem_size.png)

## Random Forest
<pre><code>
library(party)
library(randomForest)

output.forest <- randomForest(Comp ~ Sub + SubAnimacy + DO + sem_humq + sem_abstract + 
                                sem_freq + sem_physq + sem_size + sem_quant + sem_dist + 
                                sem_speed, data = data, importance = TRUE)

print(output.forest) 

importance(output.forest)
varImpPlot(output.forest, type=2)
</code></pre>

Выдача:
<pre><code>
Call:
 randomForest(formula = Comp ~ Sub + SubAnimacy + DO + sem_humq +      sem_abstract + sem_freq + sem_physq + sem_size + sem_quant +      sem_dist + sem_speed, data = data, importance = TRUE) 
               Type of random forest: regression
                     Number of trees: 500
No. of variables tried at each split: 3

          Mean of squared residuals: 0.2224508
                    % Var explained: -1.4
                    
                %IncMSE IncNodePurity
Sub            3.682304     1.2038208
SubAnimacy    -9.684500     0.3185882
DO             2.630211     0.9253108
sem_humq       8.296805     0.8066256
sem_abstract   1.800890     0.5335263
sem_freq      -8.572786     0.1697123
sem_physq     -3.332269     0.3325019
sem_size      10.931057     0.7743413
sem_quant     12.236944     1.4784960
sem_dist       3.386108     0.6325609
sem_speed    -10.501949     0.1975427
</code></pre>

![random_forest](/random_forest.png)

## Результат
В соответствии с данными логистической регрессии, t- теста и random forest можно сказать, что основным выявленным значимым фактором для определения наличия или отсутствия компаратива является присутствие субъекта и его одушевленность. Также выявлено, что при одушевленности субъекта семантический класс наречия связан с качеством человека (что кажется более менее очевидным)


