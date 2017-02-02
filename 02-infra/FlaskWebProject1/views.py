from datetime import datetime
from flask import Flask, render_template, url_for, request
from FlaskWebProject1 import app
import socket, sys, random, time, math

def sample(p):
    x, y = random.random(),random.random()
    return 1 if x*x + y*y < 1 else 0

def calcula_pi(p):
    return 4.0*(reduce(lambda a, b: a + b, map(sample,xrange(0, p))))/p

@app.route("/")
def hello():
    return render_template('hello.html')

@app.route("/check")
def check():
    machine_name=socket.gethostname()
    if machine_name[-1].isdigit():
        parity=int(machine_name[-1])%2
    else:
        parity=2
    
    return render_template('check.html',machine=machine_name,fondo=parity)

@app.route("/hi", methods=['GET', 'POST'])
def hi():
    if request.method=='GET':
        return "<h1 style='color:green'>Estamos en Hi!</h1>"
    else:
        num_puntos=int(request.form['primercampo'])
        start_time = time.time()
        valor=calcula_pi(num_puntos)
        tiempo = time.time()-start_time
        error=abs(math.pi-valor)

        return render_template('hi.html', puntos=num_puntos, valor=valor, tiempo=tiempo, error=error)

@app.route("/metecosas")
def metecosas():
    return render_template('metecosas.html')


@app.route('/home')
def home():
    """Renders the home page."""
    return render_template(
        'index.html',
        title='Home Page',
        year=datetime.now().year,
    )

@app.route('/contact')
def contact():
    """Renders the contact page."""
    return render_template(
        'contact.html',
        title='Contact',
        year=datetime.now().year,
        message='Your contact page.'
    )

@app.route('/about')
def about():
    """Renders the about page."""
    return render_template(
        'about.html',
        title='About',
        year=datetime.now().year,
        message='Your application description page.'
    )
