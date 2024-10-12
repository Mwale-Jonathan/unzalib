# context processor to add default global template valuables
from django.conf import settings
from django.conf.urls.static import static


def app_details(request):
    # Add the settings you want to access in the templates
    return {
        "app_name_short": "UNZALIB",
        "app_name_full": "University Of Zambia Online Library",
    }
