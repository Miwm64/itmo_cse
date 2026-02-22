import polars as pl
from great_tables import GT, style, loc

pl.Config.set_tbl_rows(-1)
pl.Config.set_tbl_cols(-1)
pl.Config.set_fmt_str_lengths(500)
pl.Config.set_tbl_width_chars(5000)

filepath = "it_lab5_book.xlsx"

def solve():
    df = pl.read_excel(filepath, has_header=False)
    df = df[0:15]
    df = df.select(df.columns[:25])
    df = df.drop(df.columns[5])

    df_first = df[:3]
    df_rest = df[3:]


    df_rest = df_rest.with_columns(
        pl.concat_str([pl.col(f"column_{i}") for i in range(7, 26)], separator="")
        .alias("column_7")
    )

    df = df_rest.select(df.columns[:5] + ["column_7"])

    new_cols = [f"column_{i}" for i in range(8, 26)]
    df = df.with_columns([pl.lit(None).alias(c) for c in new_cols])


    df = pl.concat([df_first, df], how="vertical")

    gt_table = (
        GT(df)
        # .tab_options(column_labels_hidden=True)
    )

    gt_table = gt_table.tab_style(
        style=style.borders(
            sides="left",
            color="green",
            style="solid",
            weight="3px"
        ),
        locations=loc.body(columns=[0, 1, 2, 3, 4], rows = [i for i in range(3, 15)])
    )
    gt_table = gt_table.tab_style(
        style=style.borders(
            sides="right",
            color="green",
            style="solid",
            weight="3px"
        ),
        locations=loc.body(columns=[0, 1, 2, 3, 4, 23], rows = [i for i in range(3, 15)])
    )
    gt_table = gt_table.tab_style(
        style=style.borders(
            sides="top",
            color="green",
            style="solid",
            weight="3px"
        ),
        locations=loc.body(rows=[3])
    )
    gt_table = gt_table.tab_style(
        style=style.borders(
            sides="bottom",
            color="green",
            style="solid",
            weight="3px"
        ),
        locations=loc.body(rows=[14])
    )

    gt_table.show()

if __name__ == "__main__":
    solve()