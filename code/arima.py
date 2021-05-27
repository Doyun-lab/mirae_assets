
import warnings
warnings.filterwarnings("ignore")

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline

from sklearn.ensemble import RandomForestRegressor

from keras.models import Model
from keras.optimizers import Adam
from keras.utils import to_categorical
from tensorflow.keras.preprocessing.image import ImageDataGenerator

from tensorflow.keras.models import Model
from tensorflow.keras.layers import (
    Conv2D, BatchNormalization, Dropout, MaxPool2D, Activation,
    Flatten, Dense, Input, Concatenate, LeakyReLU, Add, AveragePooling2D
)

from sklearn.model_selection import train_test_split
from tensorflow.keras.callbacks import LearningRateScheduler

# Top 10개 종목에 대한 예측 진행
trade = pd.read_csv('../file/trade_train.csv').iloc[:,1:]
stock = pd.read_csv('../file/stocks.csv')
group3348_top = pd.read_csv('../file/group33-48_stock.csv').iloc[:,1:]

# 기준년월 데이터 프레임 만들어서 merge로 합치기(Nan는 0 처리)
for i in range(len(group3348_top.columns)):
    id_group = trade['그룹번호'] == group3348_top.columns[i]
    globals()['MAD{}'.format(i+33)] = trade[id_group]

standard = pd.DataFrame({'기준년월':list(range(201907,201913)) + list(range(202001,202007))})

for j in range(len(group3348_top)):
    group_stock = MAD33['종목번호'] == group3348_top['MAD33'][j]
    globals()['MAD33_filter{}'.format(j)] = pd.merge(standard, MAD33[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD34['종목번호'] == group3348_top['MAD34'][j]
    globals()['MAD34_filter{}'.format(j)] = pd.merge(standard, MAD34[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD35['종목번호'] == group3348_top['MAD35'][j]
    globals()['MAD35_filter{}'.format(j)] = pd.merge(standard, MAD35[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD36['종목번호'] == group3348_top['MAD36'][j]
    globals()['MAD36_filter{}'.format(j)] = pd.merge(standard, MAD36[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD37['종목번호'] == group3348_top['MAD37'][j]
    globals()['MAD37_filter{}'.format(j)] = pd.merge(standard, MAD37[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD38['종목번호'] == group3348_top['MAD38'][j]
    globals()['MAD38_filter{}'.format(j)] = pd.merge(standard, MAD38[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD40['종목번호'] == group3348_top['MAD40'][j]
    globals()['MAD40_filter{}'.format(j)] = pd.merge(standard, MAD40[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD41['종목번호'] == group3348_top['MAD41'][j]
    globals()['MAD41_filter{}'.format(j)] = pd.merge(standard, MAD41[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD42['종목번호'] == group3348_top['MAD42'][j]
    globals()['MAD42_filter{}'.format(j)] = pd.merge(standard, MAD42[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD43['종목번호'] == group3348_top['MAD43'][j]
    globals()['MAD43_filter{}'.format(j)] = pd.merge(standard, MAD43[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD44['종목번호'] == group3348_top['MAD44'][j]
    globals()['MAD44_filter{}'.format(j)] = pd.merge(standard, MAD44[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD45['종목번호'] == group3348_top['MAD45'][j]
    globals()['MAD45_filter{}'.format(j)] = pd.merge(standard, MAD45[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD46['종목번호'] == group3348_top['MAD46'][j]
    globals()['MAD46_filter{}'.format(j)] = pd.merge(standard, MAD46[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD47['종목번호'] == group3348_top['MAD47'][j]
    globals()['MAD47_filter{}'.format(j)] = pd.merge(standard, MAD47[group_stock], how='left').fillna(0)
    
    group_stock = None
    group_stock = MAD48['종목번호'] == group3348_top['MAD48'][j]
    globals()['MAD48_filter{}'.format(j)] = pd.merge(standard, MAD48[group_stock], how='left').fillna(0)

# 데이터 확인
plt.plot(MAD48_filter0['매도고객수'])

# 전역 변수 목록 가져와 key값 저장

global_var = list(globals().keys())
variable_list = list()

for idx, word in enumerate(global_var):
    if global_var[idx].startswith('MAD') == True and len(global_var[idx]) >= 6:
        variable_list.append(global_var[idx])

variable_list.sort()

# 시계열 모델 구축

from statsmodels.tsa.arima_model import ARIMA

order = (1, 0, 0)
for i in range(len(variable_list)):
    model = ARIMA(globals()[variable_list[i]].iloc[:,6], order)
    globals()['fit_{}'.format(i)] = model.fit(trend='nc',full_output=True, disp=1)

fit_0.plot_predict()

for i in range(len(variable_list)):
    globals()['fore_{}'.format(i)] = globals()['fit_{}'.format(i)].forecast(steps=1)
    if i % 10 == 0:
        print('-------------------')
    print(globals()['fore_{}'.format(i)][0])

# MAD40 그룹과 MAD41 그룹만 3등과 4등의 위치가 바뀌고 나머지는 변화 X
train_x = data.iloc[0:25285,4:]
train_y = data.iloc[0:25285,3]
val_x = data.iloc[25285:,4:]
val_y = data.iloc[25285:,3]

train_x = train_x.values.reshape(-1,5)
train_y = train_y.values.reshape(-1,1)
val_x = val_x.values.reshape(-1,5)
val_y = val_y.values.reshape(-1,1)

input_layer = Input(shape = train_x.shape[1:])
x = Dense(256, activation='relu')(input_layer)
x = Dense(256, activation='relu')(x)
x = Dense(512, activation='relu')(x)
x = Dense(512, activation='relu')(x)
output_layer = Dense(1000, activation='sigmoid')(x)

model = Model(input_layer, output_layer)
model.summary()

model.compile(loss='mean_squared_error',optimizer='Adam')


annealer = LearningRateScheduler(lambda x: 1e-3 * 0.97 ** x)

hist = model.fit(train_x, train_y, epochs=5, batch_size=32)

# test 데이터셋을 그룹별 - 종목별 나눠서 넣어보면 답이 나옴

loss_and_metrics = model.evaluate(x_test, y_test, batch_size=32)
