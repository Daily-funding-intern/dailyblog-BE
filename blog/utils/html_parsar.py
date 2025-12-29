from bs4 import BeautifulSoup

def extract_description(html: str, max_length=100):
    soup = BeautifulSoup(html, 'html.parser')
    
    # og:description에서 먼저 뽑음
    meta = soup.find('meta', property='og:description')
    if meta and meta.get('content'):
        return meta['content'][:max_length]

    # og:description에 없으면, 본문에서 뽑음
    text = soup.get_text(separator=' ', strip=True)
    return text[:max_length]