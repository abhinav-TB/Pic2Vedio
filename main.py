# python3 -m venv venv
# . venv/bin/activate
# pip install streamlit
# pip install torch torchvision
# streamlit run main.py
import streamlit as st
from PIL import Image
from model import generate
from numpy import asarray
import imageio
#import style
import wget
import os
if not os.path.exists('./vox-cpk.pth.tar'):
    print("downloading model")
    wget.download('https://objectstorage.ap-hyderabad-1.oraclecloud.com/n/ax9kets4h5ld/b/pic2video_pth/o/vox-cpk.pth.tar')
else :
    print("model found")    
st.title('Pic2video Generator')
img = st.file_uploader("upload image")



# emotion = st.sidebar.selectbox(
#      'Select emotion',
#      ('smile', 'laughter', 'cry')
#  )
col1, col2 = st.beta_columns(2)
if img:
   
    col1.write('### Source image:')
    image = Image.open(img)
    col1.image(image )  # image: numpy array
    # input_vedio = open('./input/04.mp4' , 'rb')
    # video_bytes = input_vedio.read()
    # col2.write("### Source video")
    # col2.video(video_bytes )

clicked = st.button('Stylize')

if clicked:
    # image = imageio.imread(image)
    with st.spinner('Processing...'):
        output = generate(asarray(image))
        video_file = open('result.mp4', 'rb')
        video_bytes = video_file.read()
    st.success("Done!")
    col2.write('### Output Video')
    col2.video(video_bytes)
# model = style.load_model(model)
# style.stylize(model, input_image, output_image)

# st.write('### Output image:')
#image = Image.open(output_image)
#st.image(image, width=400)
