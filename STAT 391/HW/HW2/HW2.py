#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import math
import matplotlib.pyplot as plt


# In[2]:


theta1 = 0.3141
theta0 = 1 - theta1
n = 100


# In[3]:


# (5.1) Get the set of possible values of S-theta1
values = []
for i in range(n+1):
    values.append(i/100)
print(values)
# 
if theta1 in values:
    print(True)
else:
    print(False)


# In[30]:


# (5.2) Write the expression of the probability of each outcome in S-theta1
# 
probabilities = []
for i in range(n+1):
    temp = pow(theta1, i) * pow(theta0, n-i) * (math.factorial(100)/(math.factorial(i)*math.factorial(100-i)))
    probabilities.append(temp)
print(probabilities)


# In[28]:


# (5.3) 
x = np.zeros(101)
for i in range(101):
    x[i] = i
y = np.zeros(101)
for i in range(101):
    y[i] = math.log(1+probabilities[i])

plt.stem(x, y, use_line_collection=True)


# In[34]:


# (5.4)
errorAbs = 0
errorRel = 0
for i in range(n+1):
    if abs(values[i] - theta1) > 0.02:
        errorAbs += probabilities[i]
    if (abs(values[i] - theta1)/theta1) > 0.02:
        errorRel += probabilities[i]
print(errorAbs)
print(errorRel)


# In[ ]:




