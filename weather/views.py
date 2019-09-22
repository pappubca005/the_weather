import requests
from django.shortcuts import render
from .models import City
from .forms import CityForm

def index(request):
    # /2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22
    units='metric'
    if units=='metric':
        u='C'
    elif units=='imperial':
        u='F'
    url = 'http://api.openweathermap.org/data/2.5/weather?q={}&units='+ units + '&appid=512e7a2a06bc866b1f650b98b2f81b02'
    # url = 'http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=38c7e33f31af6134e14467897afb13d3'
    if request.method == 'POST':
        form = CityForm(request.POST)
        form.save()

    form = CityForm()

    cities = City.objects.all()

    weather_data = []

    for city in cities:

        r = requests.get(url.format(city)).json()

        city_weather = {
            'city' : city.name,
            'temperature' : r['main']['temp'],
            'description' : r['weather'][0]['description'],
            'icon' : r['weather'][0]['icon'],
            'units':u
        }

        weather_data.append(city_weather)

    context = {'weather_data' : weather_data, 'form' : form}
    return render(request, 'weather/weather.html', context)
