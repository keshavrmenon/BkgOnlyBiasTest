#include<iostream>
void plot() {
  gStyle->SetOptFit();

  TFile *f = new TFile("higgsCombine_test_fit.MultiDimFit.mH125.123456.root");
  TTree *t = (TTree*) f->Get("limit");

  TH1F *h_pull = new TH1F("h_pull","h_pull", 100, -5, 5);
  
  float ext, norm, in;

  t->SetBranchAddress("shapeBkg_bkg_mass_ch1_DoubleHTag_0_13TeV__norm", &norm);
  t->SetBranchAddress("shapeBkg_bkg_mass_ch1_DoubleHTag_0_13TeV_integral_extended", &ext);
  t->SetBranchAddress("shapeBkg_bkg_mass_ch1_DoubleHTag_0_13TeV_integral",&in);

  int n = (int) t->GetEntries();

  for (int i=0 ; i<n; i++){
    t->GetEntry(i);
    float fit = ext, err = sqrt(norm*in);
    cout<<fit<<'\n';
    float pull = (0.491963-fit)/err;
    h_pull->Fill(pull);
  }
  h_pull->Fit("gaus");
  h_pull->Draw();
}
