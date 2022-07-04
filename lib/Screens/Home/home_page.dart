import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/Bloc%20Provider/category/category_cubit.dart';
import 'package:myapp/Components/customAppBar.dart';
import 'package:myapp/Screens/Home/components/custom_banner.dart';
import 'package:myapp/Screens/Home/components/custom_category_card.dart';
import 'package:myapp/Screens/Home/components/custom_product_card.dart';
import 'package:myapp/Screens/Home/components/heading.dart';
import 'package:myapp/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
            child: CustomAppBar(ispress: false)),
        body: SingleChildScrollView(
            child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Heading(name: 'Browse Category'),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (BuildContext context, state) {
                if (state is CategoryLoaded) {
                  return ListView.builder(
                      itemCount: state.snap.size,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomCategoryCard(
                            name: state.snap.docs[index].get('category'),
                            img: state.snap.docs[index].get('img'),
                            press: () {
                              Navigator.pushNamed(context, '/sublist',
                                  arguments: state.snap.docs[index]);
                            });
                      });
                } else if (state is CategoryLoading) {
                  return loading;
                } else {
                  return wrong;
                }
              })),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: CustomBanner(),
        ),
        BlocBuilder<CategoryCubit, CategoryState>(
            builder: (BuildContext context, state) {
          if (state is CategoryLoaded) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.snap.size,
                itemBuilder: (BuildContext context, int mainindex) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          state.snap.docs[mainindex]['subcategory'].length,
                      itemBuilder: (BuildContext context, int subindex) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Column(
                            children: [
                              Heading(
                                  name: state.snap.docs[mainindex]
                                      ['subcategory'][subindex]['Name']),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.02),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 15,
                                            crossAxisCount: 2),
                                    itemCount: 4,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CustomProductCard(
                                        product: state.snap.docs[mainindex]
                                            ['Sub_Category'][state.snap
                                                .docs[mainindex]['subcategory']
                                            [subindex]['Name']][index],
                                        press: () {
                                          Navigator.pushNamed(context, '/detail',
                                              arguments: state
                                                          .snap.docs[mainindex]
                                                      ['Sub_Category'][
                                                  state.snap.docs[mainindex]
                                                          ['subcategory']
                                                      [subindex]['Name']][index]);
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      });
                });
          } else if (state is CategoryLoading) {
            return loading;
          } else {
            return wrong;
          }
        })
      ],
    )));
  }
}
