from pathlib import Path
from PIL import Image

root = Path(__file__).resolve().parents[1]
source = Image.open('/home/ubuntu/upload/intern.az.png').convert('RGBA')
public = root / 'public'
public.mkdir(exist_ok=True)

source.save(public / 'intern-az-logo.png')
source.resize((32, 32), Image.Resampling.LANCZOS).save(public / 'favicon.ico', sizes=[(32, 32)])
source.resize((180, 180), Image.Resampling.LANCZOS).convert('RGB').save(public / 'apple-touch-icon.png', optimize=True)
source.resize((192, 192), Image.Resampling.LANCZOS).save(public / 'icon-192.png', optimize=True)
source.resize((512, 512), Image.Resampling.LANCZOS).save(public / 'icon-512.png', optimize=True)
