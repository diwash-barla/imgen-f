# Base image के रूप में एकदम लाइटवेट Python slim का इस्तेमाल करें
FROM python:3.10-slim

# Hugging Face Spaces के लिए non-root यूज़र (ID 1000) बनाना ज़रूरी है
RUN useradd -m -u 1000 user
USER user

# यूज़र के लिए PATH सेट करें
ENV PATH="/home/user/.local/bin:$PATH"

# वर्किंग डायरेक्टरी सेट करें
WORKDIR /home/user/app

# प्रोजेक्ट की सभी फाइलों को कंटेनर में कॉपी करें और ओनरशिप 'user' को दें
COPY --chown=user . .

# pip को अपग्रेड करें और आवश्यकताओं को इंस्टॉल करें
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# पोर्ट 7860 को एक्सपोज़ करें
EXPOSE 7860

# गेटवे सर्वर को स्टार्ट करने का कमांड
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]
