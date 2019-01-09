from django.http import HttpResponse
from django.template.loader import render_to_string


def index(request):
    title = 'Demo django web app'
    author = 'gus'
    html = render_to_string('index.html', {'title': title, 'author': author})
    return HttpResponse(html)
