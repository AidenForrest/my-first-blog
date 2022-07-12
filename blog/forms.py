from django import forms
from .models import Post, Comment
from django.contrib.auth.forms import AuthenticationForm

class PostForm(forms.ModelForm):
    class Meta:
        model = Post
        fields = ('title', 'text')
        widgets = {
            'title': forms.TextInput(attrs={'style': 'border-top-width: 0px; border-left-width: 0px; border-right-width: 0px; outline: none; border-bottom-color: black; margin-bottom: 20px'}),
            'text': forms.Textarea(attrs={'style': 'border-bottom-color: black; outline: none; width: 75vw;', 'placeholder': 'Enter post body'})
        }

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ('author', 'text')
        widgets = {
            'author': forms.TextInput(attrs={'style': 'border-top-width: 0px; border-left-width: 0px; border-right-width: 0px; outline: none; border-bottom-color: black; margin-bottom: 20px'}),
            'text': forms.Textarea(attrs={'style': 'border-bottom-color: black; outline: none; width: 75vw;', 'placeholder': 'Enter post body'})
        }

class CustomLoginForm(AuthenticationForm):

  def __init__(self, *args, **kwargs):
    super().__init__(*args, **kwargs)
    self.fields['username'].widget.attrs.update(
      {'style': 'outline: none;border-top-width: 0px; border-left-width: 0px; border-right-width: 0px; outline: none; border-bottom-color: black; width: 60vw;'}
    )
    self.fields['password'].widget.attrs.update(
      {'style': 'outline: none;border-top-width: 0px; border-left-width: 0px; border-right-width: 0px; outline: none; border-bottom-color: black; width: 60vw;'}
    )