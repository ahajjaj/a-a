package com.example.myschool;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;

public class Cour1 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        getSupportActionBar().hide();
        super.onCreate(savedInstanceState);
        setContentView(R.layout.cour1test);




        final Button button1 = findViewById(R.id.subscribe);

        button1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Code here executes on main thread after user presses button
                Intent gameActivity1 = new Intent(Cour1.this, RoleActivity.class);
                startActivity(gameActivity1);
            }
        });
}}
