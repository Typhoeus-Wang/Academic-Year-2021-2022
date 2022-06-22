#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import math


# In[ ]:


#!/usr/bin/env python
import numpy as np
# Read the language statistics
def readLangStats( filename ):
    # first version
    peng = np.zeros( 26, dtype = float )
    i = 0
    for line in open( filename ):
        dum = line.split( ' ' )
        pdum = float( dum[ 2 ] )/1000.
        peng[ i ] = pdum
        i = i+1
    #second and simpler version
    pengi = []
    for line in open( filename ):
        dum = line.split( ' ' )
        pdum = float( dum[ 2 ] )/1000.
        pengi.append( pdum )
    peng = np.array( pengi )
    return peng
def normalize( vec):
    svec = sum( vec )
    vec = vec / svec
    return None  #optional
# main 
peng = readLangStats( 'english.dat' )
pger = readLangStats( 'german.dat' )
pfr = readLangStats( 'french.dat' )
psp = readLangStats( 'spanish.dat' )
alphabet = 'abcdefghijklmnopqrstuvwxyz'
nletters = len(alphabet)
languages = ['English', 'German ', 'Spanish', 'French ' ] #space added to make them all equal length
while True:
    sentence = input('Enter a sentence:' )
    sentence = sentence.lower()
    #
    #  put your code here
    #
    # print results
    
    # Simplify the sentence
    s = ""
    for i in sentence:
        if i in alphabet:
            s+=i
    
    # calculate the number of occurence in the sentence
    frequency = []
    for i in range(26):
        frequency.append(0)
        
    for i in s:
        index = ord(i) - 97
        if index <= 27 and index >= 0:
            frequency[index] = frequency[index] + 1
    
    print(frequency)

    
    result = np.zeros(4, dtype = float)
    # Calculate the log-likelihood for English
    pE = 1
    for i in range(26):
        pE = pE * pow(peng[i], frequency[i])
    result[0] = math.log(pE, 2)
    
    # Calculate the log-likelihood for German
    pG = 1
    for i in range(26):
        pG = pG * pow(pger[i], frequency[i])
    result[1] = math.log(pG, 2)
    
    # Calculate the log-likelihood for Spanish
    pS = 1
    for i in range(26):
        pS = pS * pow(psp[i], frequency[i])
    result[2] = math.log(pS, 2)
    
    # Calculate the log-likelihood for French
    pF = 1
    for i in range(26):
        pF = pF * pow(pfr[i], frequency[i])
    result[3] = math.log(pF, 2)
    
    print("Log-likelihoods (in bits)")
    print("English: " + str(result[0]))
    print("German: " + str(result[1]))
    print("Spanish: " + str(result[2]))
    print("French: " + str(result[3]))

    ilang = result.argmax()
    print('The most likely language of %s is %s' %(sentence, languages[ ilang ]))


# In[ ]:




