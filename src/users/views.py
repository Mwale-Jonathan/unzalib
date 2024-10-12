from django.shortcuts import render, redirect, reverse
from django.contrib.auth.decorators import login_required
from .forms import ProfileUpdateForm
from django.contrib import messages


# Create your views here.
@login_required
def profile(request):
    form = ProfileUpdateForm(instance=request.user)
    if request.method == "POST":
        form = ProfileUpdateForm(request.POST, request.FILES, instance=request.user)
        if form.is_valid():
            form.save()
            messages.success(
                request,
                f"{user.username}, your profile has been successifully updated.",
            )
            return redirect(reverse("profile"))
    context = {
        "title": request.user.username,
        "form": form,
    }
    return render(request, "users/profile.html", context)
