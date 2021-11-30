#!/usr/bin/env python
# coding: utf-8

# In[2]:


from sklearn.linear_model import Ridge
import numpy as np

n_rows = 20
n_cols = 4
Xdata = np.random.rand(n_rows,n_cols)
Ydata = np.random.rand(n_rows)


ridgeReg = Ridge(alpha = 1.0)
ridgeReg.fit(Xdata, Ydata)


# In[3]:


ridgeReg.predict(Xdata)


# In[4]:


#Error
Residual =Ydata - ridgeReg.predict(Xdata)


# In[5]:


Residual


# In[7]:


np.square(Residual)


# In[9]:


np.square(Residual).mean()


# In[11]:


ridgeReg = Ridge(alpha = 2.0)
ridgeReg.fit(Xdata, Ydata)
ridgeReg.predict(Xdata)
Residual =Ydata - ridgeReg.predict(Xdata)
np.square(Residual).mean()


# In[12]:


ridgeReg = Ridge(alpha = 0.5)
ridgeReg.fit(Xdata, Ydata)
ridgeReg.predict(Xdata)
Residual =Ydata - ridgeReg.predict(Xdata)
np.square(Residual).mean()


# In[14]:


ridgeReg = Ridge(alpha = 0.01)
ridgeReg.fit(Xdata, Ydata)
ridgeReg.predict(Xdata)
Residual =Ydata - ridgeReg.predict(Xdata)
np.square(Residual).mean()


# In[15]:


ridgeReg = Ridge(alpha = 0.001)
ridgeReg.fit(Xdata, Ydata)
ridgeReg.predict(Xdata)
Residual =Ydata - ridgeReg.predict(Xdata)
np.square(Residual).mean()


# In[16]:


ridgeReg = Ridge(alpha = 20)
ridgeReg.fit(Xdata, Ydata)
ridgeReg.predict(Xdata)
Residual =Ydata - ridgeReg.predict(Xdata)
np.square(Residual).mean()


# In[21]:


Xdata


# In[22]:


Xdata[0:15,].shape


# In[24]:


Xtrain = Xdata[0:15,]
Xtest =Xdata[15:21,]
Ytrain = Ydata[0:15,]
Ytest =Ydata[15:21,]


# In[25]:


ridgeReg = Ridge(alpha = 0.01)
ridgeReg.fit(Xtrain, Ytrain)
ridgeReg.predict(Xtest)
Residual =Ytest - ridgeReg.predict(Xtest)
np.square(Residual).mean()


# In[26]:


ridgeReg = Ridge(alpha = 0.0)
ridgeReg.fit(Xtrain, Ytrain)
ridgeReg.predict(Xtest)
Residual =Ytest - ridgeReg.predict(Xtest)
np.square(Residual).mean()


# In[27]:


ridgeReg = Ridge(alpha = 1.0)
ridgeReg.fit(Xtrain, Ytrain)
ridgeReg.predict(Xtest)
Residual =Ytest - ridgeReg.predict(Xtest)
np.square(Residual).mean()


# In[28]:


ridgeReg = Ridge(alpha = 200.0)
ridgeReg.fit(Xtrain, Ytrain)
ridgeReg.predict(Xtest)
Residual =Ytest - ridgeReg.predict(Xtest)
np.square(Residual).mean()


# In[29]:


ridgeReg = Ridge(alpha = 10.0)
ridgeReg.fit(Xtrain, Ytrain)
ridgeReg.predict(Xtest)
Residual =Ytest - ridgeReg.predict(Xtest)
np.square(Residual).mean()


# In[ ]:




