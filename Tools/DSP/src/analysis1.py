import librosa
from matplotlib import pyplot as plt

x, sampling_rate = librosa.load('./input/Hoppipolla.mp3')
print('Sampling Rate: ', sampling_rate)
plt.figure(figsize=(14, 5))
plt.plot(x[:sampling_rate * 5])
plt.title('Plot for the first 5 seconds')
plt.xlabel('Frame number')
plt.ylabel('Magnitude')
plt.show()