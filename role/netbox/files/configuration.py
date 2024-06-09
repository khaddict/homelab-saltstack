ALLOWED_HOSTS = ['netbox.homelab.lan', '192.168.0.208']

DATABASE = {
    'ENGINE': 'django.db.backends.postgresql',
    'NAME': 'netbox',
    'USER': 'netbox',
    'PASSWORD': '<password>',
    'HOST': 'localhost',
    'PORT': '',
    'CONN_MAX_AGE': 300,
}

REDIS = {
    'tasks': {
        'HOST': 'localhost',
        'PORT': 6379,
        'PASSWORD': '',
        'DATABASE': 0,
        'SSL': False,
    },
    'caching': {
        'HOST': 'localhost',
        'PORT': 6379,
        'PASSWORD': '',
        'DATABASE': 1,
        'SSL': False,
    }
}

SECRET_KEY = '<password>'
