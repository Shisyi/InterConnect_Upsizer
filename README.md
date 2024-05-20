# InterConnect_Upsizer
+ Изначальная идея  была связана через счётчик размерности T_DATA_RATIO. 
+ Адекватная реализация не удалась, не смог до конца понять протокол пердачи данных и сигналы интерфейса. Какие конкретно относятся в протоколах к m. а какие к s.

# Module
+ Для случая T_DATA_RATIO = 2, по задумке необходим один регистр. Если бы T_DATA_RATIO было больше, необходима была бы память (или множество регистров), обращение к которой реализовывалось также через счётчик.
+ Скорее всего архитектура сильно упростится, если все зависимости расписать через булеву алгебру.

# TestBench
+ В tb прописан вариант поведения когда входные данные задаются 4-х разрядным счётчиком, а остальные сигналы которые задаются на входе, практически соответствуют рисунку из задания.
