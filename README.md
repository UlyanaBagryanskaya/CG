# Проект по НИСу "Грамматика конструкций"
Багрянская Ульяна, БКЛ143

### Материалы
Данные (https://github.com/UlyanaBagryanskaya/CG/blob/master/kuda_kak_nar.xml)  
[Ссылка на код, здесь целиком с комментарием](https://github.com/...) ( или ниже по тексту отдельными блоками )

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

## Анализ: дескриптивная статистика
В этом разделе располагаются таблицы, графики и обсуждение дистрибуции значений в отдельных переменных и взаимной дистрибуции пар переменных.
Рекомендуются гистограммы, density plots, боксплоты (или violin plots), метрики корреляции и статистической значимости. Если вы используете метрику хи-квадрат, не забывайте посчитать к ней effect size.

## Мультифакторный анализ
Здесь рекомендуется использовать один из следующих подходов к моделированию/анализу данных:  
* коллострукционный анализ (в сопоставлении с метриками из Schmid et al.)  
* дерево решений ( + случайный лес для выявления важности переменных (variable importance))  
* логистическая регрессия (привести примеры нескольких моделей, закончив оптимальной, в которой остаются только значимые факторы)  
* (множественный) анализ соответствий ((M)CA), возможно, в сочетании с кластеризацией/k-means  
Требуется показать output модели(ей) и привести графики

## Содержательный лингвистический анализ результатов статистического анализа
Без содержательного анализа факторов выбора конструкции (взаимодействия выделенных вами переменных, их значимости/важности) проект не будет считаться выполненным.   

## Обсуждение использованных квантитативных методов
Тут или ранее по ходу анализа нужно обсудить аккуратность (точность) классифицирующих моделей, classification power, adjusted R2, goodness of fit и т.п. -- стандартные показатели качества моделирования, а также важность / значимость факторов. 
В заключение вы можете предложить идеи по дальнейшей работе с данными и их статистическим анализом. # CG
