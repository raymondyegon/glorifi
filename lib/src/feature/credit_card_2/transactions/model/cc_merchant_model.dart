import 'package:get/get.dart';

class CCMerchantModel extends GetxService {
  CCMerchantModel(
      {this.id,
      this.name,
      this.secondary_merchant_name,
      this.display_name,
      this.merchant_brand,
      this.secondary_merchant_brand,
      this.merchant_type,
      this.category,
      this.phone_number,
      this.cover_image,
      this.google_map_url,
      this.website,
      this.street_number,
      this.street_name,
      this.address_details,
      this.city,
      this.state,
      this.country,
      this.zipcode,
      this.formatted_address,
      this.latitude,
      this.longitude,
      this.cp_merchant_category_code,
      this.cardacceptor_name_location});

  String? id;
  String? name;
  String? secondary_merchant_name;
  String? display_name;
  MerchantBrand? merchant_brand;
  SecondaryMerchantBrand? secondary_merchant_brand;
  String? merchant_type;
  MerchantCategory? category;
  String? phone_number;
  String? cover_image;
  String? google_map_url;
  String? website;
  String? street_number;
  String? street_name;
  String? address_details;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? formatted_address;
  String? latitude;
  String? longitude;
  String? cp_merchant_category_code;
  String? cardacceptor_name_location;

  CCMerchantModel copyWith(
          {String? id,
          String? name,
          String? secondary_merchant_name,
          String? display_name,
          MerchantBrand? merchant_brand,
          SecondaryMerchantBrand? secondary_merchant_brand,
          String? merchant_type,
          MerchantCategory? category,
          String? phone_number,
          String? cover_image,
          String? google_map_url,
          String? website,
          String? street_number,
          String? street_name,
          String? address_details,
          String? city,
          String? state,
          String? country,
          String? zipcode,
          String? formatted_address,
          String? latitude,
          String? longitude,
          String? cp_merchant_category_code,
          String? cardacceptor_name_location}) =>
      CCMerchantModel(
        id: id ?? this.id,
        name: name ?? this.name,
        secondary_merchant_name:
            secondary_merchant_name ?? this.secondary_merchant_name,
        display_name: display_name ?? this.display_name,
        merchant_brand: merchant_brand ?? this.merchant_brand,
        secondary_merchant_brand:
            secondary_merchant_brand ?? this.secondary_merchant_brand,
        merchant_type: merchant_type ?? this.merchant_type,
        category: category ?? this.category,
        phone_number: phone_number ?? this.phone_number,
        cover_image: cover_image ?? this.cover_image,
        google_map_url: google_map_url ?? this.google_map_url,
        website: website ?? this.website,
        street_number: street_number ?? this.street_number,
        street_name: street_name ?? this.street_name,
        address_details: address_details ?? this.address_details,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        zipcode: zipcode ?? this.zipcode,
        formatted_address: formatted_address ?? this.formatted_address,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        cp_merchant_category_code:
            cp_merchant_category_code ?? this.cp_merchant_category_code,
        cardacceptor_name_location:
            cardacceptor_name_location ?? this.cardacceptor_name_location,
      );

  factory CCMerchantModel.fromJson(Map<String, dynamic> json) =>
      CCMerchantModel(
          id: json["id"],
          name: json["name"],
          secondary_merchant_name: json["secondary_merchant_name"],
          display_name: json["display_name"],
          merchant_brand: MerchantBrand.fromJson(json["merchant_brand"]),
          secondary_merchant_brand:
              SecondaryMerchantBrand.fromJson(json["secondary_merchant_brand"]),
          merchant_type: json["merchant_type"],
          category: MerchantCategory.fromJson(json["category"]),
          phone_number: json["phone_number"],
          cover_image: json["cover_image"],
          google_map_url: json["google_map_url"],
          website: json["website"],
          street_number: json["street_number"],
          street_name: json["street_name"],
          address_details: json["address_details"],
          city: json["city"],
          state: json["state"],
          country: json["country"],
          zipcode: json["zipcode"],
          formatted_address: json["formatted_address"],
          latitude: json["latitude"],
          longitude: json["longitude"],
          cp_merchant_category_code: json["cp_merchant_category_code"],
          cardacceptor_name_location: json["cardacceptor_name_location"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "secondary_merchant_name": secondary_merchant_name,
        "display_name": display_name,
        "merchant_brand": merchant_brand?.toJson(),
        "secondary_merchant_brand": secondary_merchant_brand?.toJson(),
        "merchant_type": merchant_type,
        "category": category?.toJson(),
        "phone_number": phone_number,
        "cover_image": cover_image,
        "google_map_url": google_map_url,
        "website": website,
        "street_number": street_number,
        "street_name": street_name,
        "address_details": address_details,
        "city": city,
        "state": state,
        "country": country,
        "zipcode": zipcode,
        "formatted_address": formatted_address,
        "latitude": latitude,
        "longitude": longitude,
        "cp_merchant_category_code": cp_merchant_category_code,
        "cardacceptor_name_location": cardacceptor_name_location,
      };
}

class MerchantBrand {
  MerchantBrand({
    this.id,
    this.name,
    this.logo_image,
  });

  String? id;
  String? name;
  String? logo_image;

  MerchantBrand copyWith({String? id, String? name, String? logo_image}) =>
      MerchantBrand(
        id: id ?? this.id,
        name: name ?? this.name,
        logo_image: logo_image ?? this.logo_image,
      );

  factory MerchantBrand.fromJson(Map<String, dynamic> json) => MerchantBrand(
        id: json["id"],
        name: json["name"],
        logo_image: json["logo_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo_image": logo_image,
      };
}

class SecondaryMerchantBrand {
  SecondaryMerchantBrand({
    this.id,
    this.name,
    this.logo_image,
  });

  String? id;
  String? name;
  String? logo_image;

  SecondaryMerchantBrand copyWith(
          {String? id, String? name, String? logo_image}) =>
      SecondaryMerchantBrand(
        id: id ?? this.id,
        name: name ?? this.name,
        logo_image: logo_image ?? this.logo_image,
      );

  factory SecondaryMerchantBrand.fromJson(Map<String, dynamic> json) =>
      SecondaryMerchantBrand(
        id: json["id"],
        name: json["name"],
        logo_image: json["logo_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo_image": logo_image,
      };
}

class MerchantCategory {
  MerchantCategory(
      {this.id,
      this.name,
      this.icon_image,
      this.merchant_image,
      this.cover_image});

  String? id;
  String? name;
  String? icon_image;
  String? merchant_image;
  String? cover_image;

  MerchantCategory copyWith(
          {String? id,
          String? name,
          String? icon_image,
          String? merchant_image,
          String? cover_image}) =>
      MerchantCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        icon_image: icon_image ?? this.icon_image,
        merchant_image: merchant_image ?? this.merchant_image,
        cover_image: cover_image ?? this.cover_image,
      );

  factory MerchantCategory.fromJson(Map<String, dynamic> json) =>
      MerchantCategory(
        id: json["id"],
        name: json["name"],
        icon_image: json["icon_image"],
        merchant_image: json["merchant_image"],
        cover_image: json["cover_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_image": icon_image,
        "merchant_image": merchant_image,
        "cover_image": cover_image,
      };
}
