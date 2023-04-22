from flask import Flask, render_template, request
from sqlalchemy import create_engine
import pandas as pd
import matplotlib.pyplot as plt
import io
import base64
import urllib.parse
import plotly
import plotly.express as px

app = Flask(__name__)
# map_images = {
#     "argentina": "https://example.com/maps/argentina.png",
#     "australia": "https://example.com/maps/australia.png",
#     "brazil": "https://example.com/maps/brazil.png",
#     "canada": "https://example.com/maps/canada.png",
#     "chile": "https://example.com/maps/chile.png",
#     "china": "https://example.com/maps/china.png",
#     "colombia": "https://example.com/maps/colombia.png",
#     "egypt": "https://example.com/maps/egypt.png",
#     "ethiopia": "https://example.com/maps/ethiopia.png",
#     "india": "https://example.com/maps/india.png",
#     "indonesia": "https://example.com/maps/indonesia.png",
#     "iran (islamic republic of)": "https://example.com/maps/iran.png",
#     "israel": "https://example.com/maps/israel.png",
#     "japan": "https://example.com/maps/japan.png",
#     "kazakhstan": "https://example.com/maps/kazakhstan.png",
#     "malaysia": "https://example.com/maps/malaysia.png",
#     "mexico": "https://example.com/maps/mexico.png",
#     "new zealand": "https://example.com/maps/new-zealand.png",
#     "nigeria": "https://example.com/maps/nigeria.png",
#     "pakistan": "https://example.com/maps/pakistan.png",
#     "paraguay": "https://example.com/maps/paraguay.png",
#     "peru": "https://example.com/maps/peru.png",
#     "philippines": "https://example.com/maps/philippines.png",
#     "republic of korea": "https://example.com/maps/korea.png",
#     "russian federation": "https://example.com/maps/russia.png",
#     "saudi arabia": "https://example.com/maps/saudi-arabia.png",
#     "south africa": "https://example.com/maps/south-africa.png",
#     "thailand": "https://example.com/maps/thailand.png",
#     "turkey": "https://example.com/maps/turkey.png",
#     "ukraine": "https://example.com/maps/ukraine.png",
#     "united states of america": "https://example.com/maps/usa.png",
#     "viet nam": "https://example.com/maps/vietnam.png",
#     "wld": "https://example.com/maps/world.png"
# }

# create a database engine using SQLAlchemy
password = "Password@123"
encoded_password = urllib.parse.quote_plus(password)

db_uri = f'mysql+mysqlconnector://root:{encoded_password}@localhost/project_gp15_new'
engine = create_engine(db_uri)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/submit', methods=['POST'])
def submit():
    countries = [
        "Argentina", "Australia", "Brazil", "Canada", "Chile", "China", "Colombia",
        "Egypt", "Ethiopia", "India", "Indonesia", "Iran (Islamic Republic of)",
        "Israel", "Japan", "Kazakhstan", "Malaysia", "Mexico", "New Zealand",
        "Nigeria", "Pakistan", "Paraguay", "Peru", "Philippines", "Republic of Korea",
        "Russian Federation", "Saudi Arabia", "South Africa", "Thailand", "Turkey",
        "Ukraine", "United States of America", "Viet Nam", "WLD"
    ]
    entry_year = request.form.get('entry_year')
    entry_country = request.form.get('entry_country')
    if entry_year is None or not (1990 <= int(entry_year) <= 2016):
        return "Invalid Year"
    if entry_country is None or not any(entry_country.lower() == c.lower() for c in countries):
        return f"{entry_country} data is not available"

    entry_code = "{}{}".format(entry_country.capitalize(), entry_year)
    # query the database using SQLAlchemy and load the results into a pandas dataframe
    query = f"SELECT * FROM final_view WHERE entry_code = %s"
    df = pd.read_sql(query, con=engine, params=(entry_code,))
    # list1 = [len(df)]
    # return list1

    # create pie charts using plotly and return them as HTML
    fig1 = px.pie(df[['obesity_male', 'obesity_female']].values[0],
                  values=df[['obesity_male', 'obesity_female']].values[0], names=['Male', 'Female'])
    fig2 = px.pie(df[['total_meat', 'total_grain']].values[0], values=df[['total_meat', 'total_grain']].values[0],
                  names=['Meat', 'Grain'])
    return render_template('results.html', entry_country=entry_country, entry_code=entry_code,
                           fig1=fig1.to_html(full_html=False), fig2=fig2.to_html(full_html=False))


if __name__ == '__main__':
    app.run(debug=True)
