package com.example.myschool;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.*;
import android.widget.*;
import android.content.Intent;

public class RoleActivity extends AppCompatActivity {

    TextView question;
    CheckBox parent;
    CheckBox student;
    CheckBox teacher;
    int role=-1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        getSupportActionBar().setDisplayShowTitleEnabled(false);
        getSupportActionBar().hide();
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_role);

        question = (TextView) findViewById(R.id.textView);
        parent = (CheckBox) findViewById(R.id.parent);
        student = (CheckBox) findViewById(R.id.student);
        teacher = (CheckBox) findViewById(R.id.teacher);
        student.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Code here executes on main thread after user presses button
                Intent gameActivity1 = new Intent(RoleActivity.this, SubscribeFormActivity.class);
                if(student.isChecked()) role =0;
                gameActivity1.putExtra("role",role);
                startActivity(gameActivity1);

            }
        });

        parent.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Code here executes on main thread after user presses button
                Intent gameActivity2 = new Intent(RoleActivity.this, SubscribeFormActivity.class);
                if(parent.isChecked()) role =1;
                gameActivity2.putExtra("role",role);
                startActivity(gameActivity2);
            }
        });

        teacher.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Code here executes on main thread after user presses button
                Intent gameActivity3 = new Intent(RoleActivity.this, SubscribeFormActivity.class);
                if(parent.isChecked()) role =2;
                gameActivity3.putExtra("role",role);
                startActivity(gameActivity3);
            }
        });

    }
}
