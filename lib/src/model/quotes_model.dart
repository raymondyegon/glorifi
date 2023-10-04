class QuotesResponseModel {
  bool? success;
  List<Quotes>? data;
  String? status;
  String? message;

  QuotesResponseModel({this.success, this.data, this.status, this.message});

  QuotesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Quotes>[];
      json['data'].forEach((v) {
        data!.add(Quotes.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class Quotes {
  SPOTT? sPOTT;
  TSLA? tSLA;
  AAPL? aAPL;
  SPOTT? tSLA12;
  SPOTT? fddfdfdfff;
  SPOTT? string;
  SPOTT? wewewewe;
  SPOTT? weweweweeeeeeeee;
  SPOTT? ert;
  SPOTT? erfgft;
  SPOTT? fdgfgd;
  SPOTT? dsadasdas;
  SPOTT? xcccxc;

  Quotes(
      {this.sPOTT,
      this.tSLA,
      this.aAPL,
      this.tSLA12,
      this.fddfdfdfff,
      this.string,
      this.wewewewe,
      this.weweweweeeeeeeee,
      this.ert,
      this.erfgft,
      this.fdgfgd,
      this.dsadasdas,
      this.xcccxc});

  Quotes.fromJson(Map<String, dynamic> json) {
    sPOTT = json['SPOTT'] != null ? SPOTT.fromJson(json['SPOTT']) : null;
    tSLA = json['TSLA'] != null ? TSLA.fromJson(json['TSLA']) : null;
    aAPL = json['AAPL'] != null ? AAPL.fromJson(json['AAPL']) : null;
    tSLA12 = json['TSLA12'] != null ? SPOTT.fromJson(json['TSLA12']) : null;
    fddfdfdfff =
        json['fddfdfdfff'] != null ? SPOTT.fromJson(json['fddfdfdfff']) : null;
    string = json['string'] != null ? SPOTT.fromJson(json['string']) : null;
    wewewewe =
        json['wewewewe'] != null ? SPOTT.fromJson(json['wewewewe']) : null;
    weweweweeeeeeeee = json['weweweweeeeeeeee'] != null
        ? SPOTT.fromJson(json['weweweweeeeeeeee'])
        : null;
    ert = json['ert'] != null ? SPOTT.fromJson(json['ert']) : null;
    erfgft = json['erfgft'] != null ? SPOTT.fromJson(json['erfgft']) : null;
    fdgfgd = json['fdgfgd'] != null ? SPOTT.fromJson(json['fdgfgd']) : null;
    dsadasdas =
        json['dsadasdas'] != null ? SPOTT.fromJson(json['dsadasdas']) : null;
    xcccxc = json['xcccxc'] != null ? SPOTT.fromJson(json['xcccxc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sPOTT != null) {
      data['SPOTT'] = sPOTT!.toJson();
    }
    if (tSLA != null) {
      data['TSLA'] = tSLA!.toJson();
    }
    if (aAPL != null) {
      data['AAPL'] = aAPL!.toJson();
    }
    if (tSLA12 != null) {
      data['TSLA12'] = tSLA12!.toJson();
    }
    if (fddfdfdfff != null) {
      data['fddfdfdfff'] = fddfdfdfff!.toJson();
    }
    if (string != null) {
      data['string'] = string!.toJson();
    }
    if (wewewewe != null) {
      data['wewewewe'] = wewewewe!.toJson();
    }
    if (weweweweeeeeeeee != null) {
      data['weweweweeeeeeeee'] = weweweweeeeeeeee!.toJson();
    }
    if (ert != null) {
      data['ert'] = ert!.toJson();
    }
    if (erfgft != null) {
      data['erfgft'] = erfgft!.toJson();
    }
    if (fdgfgd != null) {
      data['fdgfgd'] = fdgfgd!.toJson();
    }
    if (dsadasdas != null) {
      data['dsadasdas'] = dsadasdas!.toJson();
    }
    if (xcccxc != null) {
      data['xcccxc'] = xcccxc!.toJson();
    }
    return data;
  }
}

class SPOTT {
  int? c;
  dynamic d;
  dynamic dp;
  int? h;
  int? l;
  int? o;
  int? pc;
  int? t;

  SPOTT({this.c, this.d, this.dp, this.h, this.l, this.o, this.pc, this.t});

  SPOTT.fromJson(Map<String, dynamic> json) {
    c = json['c'];
    d = json['d'];
    dp = json['dp'];
    h = json['h'];
    l = json['l'];
    o = json['o'];
    pc = json['pc'];
    t = json['t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['c'] = c;
    data['d'] = d;
    data['dp'] = dp;
    data['h'] = h;
    data['l'] = l;
    data['o'] = o;
    data['pc'] = pc;
    data['t'] = t;
    return data;
  }
}

class TSLA {
  double? c;
  double? d;
  double? dp;
  double? h;
  double? l;
  double? o;
  int? pc;
  int? t;

  TSLA({this.c, this.d, this.dp, this.h, this.l, this.o, this.pc, this.t});

  TSLA.fromJson(Map<String, dynamic> json) {
    c = json['c'];
    d = json['d'];
    dp = json['dp'];
    h = json['h'];
    l = json['l'];
    o = json['o'];
    pc = json['pc'];
    t = json['t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['c'] = c;
    data['d'] = d;
    data['dp'] = dp;
    data['h'] = h;
    data['l'] = l;
    data['o'] = o;
    data['pc'] = pc;
    data['t'] = t;
    return data;
  }
}

class AAPL {
  double? c;
  double? d;
  double? dp;
  dynamic h;
  double? l;
  double? o;
  double? pc;
  int? t;

  AAPL({this.c, this.d, this.dp, this.h, this.l, this.o, this.pc, this.t});

  AAPL.fromJson(Map<String, dynamic> json) {
    c = json['c'];
    d = json['d'];
    dp = json['dp'];
    h = json['h'];
    l = json['l'];
    o = json['o'];
    pc = json['pc'];
    t = json['t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['c'] = c;
    data['d'] = d;
    data['dp'] = dp;
    data['h'] = h;
    data['l'] = l;
    data['o'] = o;
    data['pc'] = pc;
    data['t'] = t;
    return data;
  }
}
