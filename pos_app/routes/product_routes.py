from flask import Blueprint, request, jsonify
from pos_app.models import FinishGood, db
from sqlalchemy import or_

product_bp = Blueprint('product_bp', __name__, url_prefix='/products')

@product_bp.route('', methods=['GET'])
def list_products():
    search_term = request.args.get('search_term', None)
    
    query = FinishGood.query
    
    if search_term:
        # Basic search: case-insensitive search in FG_SHORT and FG_DES
        search_pattern = f"%{search_term}%"
        query = query.filter(
            or_(
                FinishGood.FG_SHORT.ilike(search_pattern),
                FinishGood.FG_DES.ilike(search_pattern)
            )
        )
        
    products = query.all()
    
    output = []
    for product in products:
        product_data = {
            "FG_ID": product.FG_ID,
            "FG_SHORT": product.FG_SHORT,
            "FG_DES": product.FG_DES,
            "FG_PRICE": float(product.FG_PRICE) if product.FG_PRICE is not None else None,
            "FG_GRP": product.FG_GRP,
            "FG_UNITS": product.FG_UNITS,
            "FG_BAR_CODE": product.FG_BAR_CODE
        }
        output.append(product_data)
        
    return jsonify(output), 200
