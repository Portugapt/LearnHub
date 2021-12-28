#bin/sh

docker run -p 8501:8501 --name=pets \
-v "$(pwd)/pets/:/models/pets/1" \
-e MODEL_NAME=pets tensorflow/serving

# Não funciona no meu PC.
# Deve ser por causa das versões.
# Testei no Rhyme, e funcionou normalmente.